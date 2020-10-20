from rest_framework import serializers
from .models import Order, OrderDetail
from django.utils import timezone as datetime
import random
from django_redis import get_redis_connection
from courses.models import Course
from django.db import transaction
from coupon.models import UserCoupon
from luffyapi.settings import constants
from users.models import Credit

class OrderModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = ["pay_type", "credit", "coupon", "total_price","real_price","order_number"]
        read_only_fields = ["total_price","real_price","order_number"]

    def validate(self, attrs):
        """验证客户端发送过来的数据"""
        pay_type = int( attrs["pay_type"] )
        is_check = False
        for choices in Order.pay_choices:
            if choices[0] == pay_type:
                is_check = True
        if is_check is False:
            raise serializers.ValidationError("支付方式不存在!")

        # 判断用户使用积分数量是否超过拥有的积分数量
        credit = int(attrs.get("credit"))
        if credit > self.context["request"].user.credit:
            raise serializers.ValidationError("对不起，您使用的积分数量超过拥有值！")

        # 判断优惠券,是否存在,是否过期
        user_coupon_id = int( attrs.get("coupon") )
        if user_coupon_id > 0:
            try:
                user_coupon = UserCoupon.objects.get(pk=user_coupon_id)
            except UserCoupon.DoesNotExist:
                raise serializers.ValidationError("对不起，当前优惠券不存在！")

            has_time = user_coupon.end_timestamp - user_coupon.now_timestamp
            if has_time < 0:
                raise serializers.ValidationError("对不起，当前优惠券已过期失效！")

        return attrs


    def create(self, validated_data):
        """生成订单"""
        with transaction.atomic():
            sid1 = transaction.savepoint()
            try:
                pay_type = validated_data.get("pay_type")
                user = self.context["request"].user
                order_number = datetime.now().strftime("%Y%m%d%H%I%S")+("%010d" % user.id)+str(random.randint(0,99999999))
                order_total_price=0
                order_real_price=0
                order = Order.objects.create(
                    name="课程购买",
                    user=user,
                    total_price=order_total_price,
                    real_price=order_real_price,
                    order_number=order_number,
                    order_status=0,
                    pay_type=pay_type,
                    credit=validated_data.get("credit"),
                    coupon=validated_data.get("coupon"),
                    order_desc="课程购买",
                )

                # 用户优惠券计算
                coupon_price = 0.0 # 优惠券抵扣价格
                # 客户端使用的优惠券id
                user_coupon_id = validated_data.get("coupon")
                # 如果用户使用了优惠券，则判断优惠券是否存在
                can_use = False
                if user_coupon_id > 0:
                    user_coupon = UserCoupon.objects.get(pk=user_coupon_id)

                # 从购物车中查询所有勾选的商品信息
                redis = get_redis_connection("cart")

                dict_cart_bytes = redis.hgetall("cart_%s" % user.id)
                set_select_bytes = redis.smembers("select_%s" % user.id)

                for course_id_bytes, expire_bytes in dict_cart_bytes.items():
                    # 如果当前商品不是集合中勾选的商品信息,则直接跳过本轮循环
                    if course_id_bytes not in set_select_bytes:
                        continue

                    expire = expire_bytes.decode()
                    course_id = course_id_bytes.decode()
                    try:
                        course = Course.objects.get(pk=course_id)
                    except Course.DoesNotExist:
                        """商品没有了...."""
                        continue

                    # 在循环中把商品的其他信息添加到商品里面
                    price = float(course.get_price(expire))
                    discount_price = float(course.discount_price(price))
                    detail = OrderDetail.objects.create(
                        order=order,
                        course=course,
                        expire=expire,
                        expire_text=course.expire_text(expire),
                        price=price,
                        real_price=discount_price,
                        discount_name=course.discount_name
                    )

                    detail.save()
                    order_total_price += price
                    order_real_price += discount_price

                    # 计算优惠券的抵扣金额
                    if user_coupon_id > 0:
                        if int(course_id) == user_coupon.coupon.course.id:
                            # 当前课程购买的价格是否满足优惠券的使用条件
                            if user_coupon.coupon.condition < discount_price:
                                can_use = True
                            else:
                                raise serializers.ValidationError(
                                    "对不起，当前优惠券只能用于购买课程《%s》时价格超过%s元才可以使用！" % (user_coupon.coupon.course.name, user_coupon.coupon.condition))

                            sale = float(user_coupon.coupon.sale[1:])
                            if user_coupon.coupon.coupon_type == 1:
                                """减免"""
                                coupon_price = sale
                            else:
                                """折扣"""
                                coupon_price = discount_price * (1-sale)

                # 判断当前优惠券绑定的课程是否存在！
                if (not can_use) and user_coupon_id > 0:
                    raise serializers.ValidationError("对不起，当前优惠券只能用于购买课程《%s》时使用！" % user_coupon.coupon.course.name)

                # 计算积分的抵扣金额
                credit = int( validated_data.get("credit") )
                credit_price = 0.0
                price_to_credit = (order_real_price - coupon_price) * constants.RMB_CREDIT
                if credit > 0:
                    if credit > price_to_credit:
                        raise serializers.ValidationError("对不起，当前积分使用数量超过订单限制！")
                    else:
                        credit_price = credit / constants.RMB_CREDIT

                order.total_price = order_total_price
                order.real_price  = float("%.2f" % (order_real_price - coupon_price - credit_price))

                # 调整优惠券的使用状态
                if user_coupon_id > 0:
                    user_coupon.is_use = True
                    user_coupon.save()

                # 扣除积分
                if credit > 0:
                    user.credit = user.credit - credit
                    user.save()

                    # 添加消费记录
                    Credit.objects.create(
                        operation=1,
                        number=0-credit,
                        user=user
                    )

                order.save()

                # 移除购物车中的商品
                pipe = redis.pipeline()
                pipe.multi()
                for set_bytes in set_select_bytes:
                    pipe.hdel("cart_%s" % user.id, set_bytes)
                pipe.delete("select_%s" % user.id)
                pipe.execute()
                return order

            except:
                transaction.savepoint_rollback(sid1)
                raise serializers.ValidationError("生成订单信息失败!")

class CourseModelSerializer(serializers.ModelSerializer):
    """课程详情"""
    class Meta:
        model = Course
        fields = ["id", "name", "course_img"]

class OrderDetailListModelSerializer(serializers.ModelSerializer):
    """订单详情"""
    course = CourseModelSerializer()
    class Meta:
        model = OrderDetail
        fields = ("price","real_price","discount_name","expire_text","course")

class OrderListModelSerializer(serializers.ModelSerializer):
    """订单列表"""
    order_courses =  OrderDetailListModelSerializer(many=True)
    class Meta:
        model = Order
        fields = ("id", "created_time", "pay_time", "order_number", "real_price", "total_price", "order_status",
                  "order_status_text", "pay_type", "order_courses")