# Create your views here.
from rest_framework.viewsets import ViewSet
from rest_framework.permissions import IsAuthenticated
from courses.models import Course
from rest_framework.response import Response
from rest_framework import status
from django_redis import get_redis_connection
class CartViewSet(ViewSet):
    permission_classes = [IsAuthenticated]
    def add_cart(self,request):
        """添加商品购物车"""
        #1. 接受数据[用户id,商品id,商品购买周期,商品勾选状态]
        user = request.user
        course_id = request.data.get("course_id")
        try:
            course = Course.objects.get(pk=course_id)
        except Course.DoesNotExist:
            return Response({"message":"商品不存在!"}, status=status.HTTP_400_BAD_REQUEST)
        except:
            return Response({"message":"未知异常"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        expire = course.min_expire # 购买周期, 0表示没有设置购买周期
        select = True # 商品勾选状态

        # 2. 保存数据到redis中
        redis = get_redis_connection("cart")
        pipe = redis.pipeline()
        pipe.multi()
        pipe.hset("cart_%s" % user.id,course_id, expire)
        pipe.sadd("select_%s" % user.id, course_id)
        pipe.execute()

        #3. 返回响应结果
        course = redis.hlen("cart_%s" % user.id)
        return Response({"message":"添加商品成功!","count": course})

    def list_cart(self,request):
        """购物车商品列表"""
        user = request.user
        """
        因为客户端显示数据,只有一个表格,而我们在redis中保存商品信息,用了2个数据结构,
        所以为方便客户端显示数据,所以我们需要重构数据
        目前保存在redis中的购物车信息
        hash:
            cart_<user_id>:{
                <course_id>:<expire>,
                <course_id>:<expire>,
                ...
            }
            
            select_<user_id>:{<course_id>,<course_id>,....}
        客户端中需要展示:
        list:[
            {
                "select": True,
                "course_img": "",
                "course_name":"",
                "expire":"",
                "price":"",
                "course_id":"",
            }
        ] 
        """
        # 1. 从redis中提取购物车所有商品信息
        redis = get_redis_connection("cart")
        dict_cart_bytes = redis.hgetall("cart_%s" % user.id)
        set_select_bytes = redis.smembers("select_%s" % user.id)

        # 2. 循环redis中的hash数据,创建一个商品列表
        data = []
        for course_id_bytes,expire_bytes in dict_cart_bytes.items():
            expire = expire_bytes.decode()
            course_id = course_id_bytes.decode()
            try:
                course = Course.objects.get(pk=course_id)
            except Course.DoesNotExist:
                """商品没有了."""
                continue
            # 2.1 在循环中把商品的其他信息添加到商品里面
            price = course.get_price(expire)
            data.append({
                "course_id": course.id,
                "course_name": course.name,
                "course_img": course.course_img.url,
                "price": price,
                "discount_price": course.discount_price(price),
                "discount_name": course.discount_name,
                "expire": int(expire),
                "expire_list": course.expire_list,
                "select": True if course_id_bytes in set_select_bytes else False
            })

        # 3. 返回购物车中的商品列表
        return Response(data)

    def change_status(self,request):
        """切换商品勾选状态"""
        # 1. 接受数据
        user = request.user
        course_id = request.data.get("course_id")
        select = request.data.get("select")

        # 2. 修改对应的勾选状态
        redis = get_redis_connection("cart")
        if select:
            redis.sadd("select_%s" % user.id,course_id)
        else:
            redis.srem("select_%s" % user.id,course_id)

        # 3. 返回响应结果
        return Response({"message":"切换状态成功!"})

    def del_cart(self,request):
        """从购物车中删除商品"""
        # 1. 接收参数[user_id, course_id]
        user = request.user
        course_id = request.query_params.get("course_id")

        # 2. 到redis根据键从hash和set里面删除对应商品信息
        redis = get_redis_connection("cart")
        pipe = redis.pipeline()
        pipe.multi()
        pipe.hdel("cart_%s" % user.id, course_id)
        pipe.srem("select_%s" % user.id, course_id)
        pipe.execute()

        # 3. 响应
        return Response({"message":"从购物车中移除商品成功!"})

    def change_expire(self,request):
        """修改购物车商品的购买有效期"""
        # 1. 接收课程[课程id,有效期]
        course_id = request.data.get("course_id")
        expire = request.data.get("expire")
        # 2. 到redis中根据用户id作为键修改对应商品的有效期
        user = request.user
        redis = get_redis_connection("cart")
        redis.hset("cart_%s" % user.id, course_id, expire)
        # 3. 响应
        return Response({"message":"修改有效期成功!"})

    def select_cart(self,request):
        """获取购物车中勾选的商品信息"""
        user = request.user
        # 1. 从redis中提取购物车所有商品信息
        redis = get_redis_connection("cart")
        dict_cart_bytes = redis.hgetall("cart_%s" % user.id)
        set_select_bytes = redis.smembers("select_%s" % user.id)

        # 2. 循环redis中的hash数据,创建一个商品列表
        data = []
        for course_id_bytes, expire_bytes in dict_cart_bytes.items():
            # 如果当前商品不是集合中勾选的商品信息,则直接跳过本轮循环
            if course_id_bytes not in set_select_bytes:
                continue

            expire = expire_bytes.decode()
            course_id = course_id_bytes.decode()
            try:
                course = Course.objects.get(pk=course_id)
            except Course.DoesNotExist:
                """商品没有了."""
                continue
            # 2.1 在循环中把商品的其他信息添加到商品里面
            price = course.get_price(expire)
            data.append({
                "course_id": course.id,
                "course_name": course.name,
                "course_img": course.course_img.url,
                "price": price,
                "discount_price": course.discount_price(price),
                "discount_name": course.discount_name,
                "expire_text": course.expire_text(expire),
            })

        # 3. 返回购物车中的商品列表
        return Response(data)