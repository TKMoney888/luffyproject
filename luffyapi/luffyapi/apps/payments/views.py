# Create your views here.
from rest_framework.views import APIView
from rest_framework.response import Response
from alipay import AliPay
from django.conf import settings
from orders.models import Order
from rest_framework.permissions import IsAuthenticated
from django.utils import timezone as datetime
from rest_framework import status
from django.db import transaction

class AlipayAPIView(APIView):
    permission_classes = [IsAuthenticated]
    @staticmethod
    def alipay():
        app_private_key_string = open(settings.ALIAPY["app_private_key_path"]).read()
        alipay_public_key_string = open(settings.ALIAPY["alipay_public_key_path"]).read()
        alipay = AliPay(
            appid=settings.ALIAPY["appid"],
            app_notify_url=None,  # 默认回调url
            app_private_key_string=app_private_key_string,
            # 支付宝的公钥，验证支付宝回传消息使用，不是你自己的公钥,
            alipay_public_key_string=alipay_public_key_string,
            sign_type=settings.ALIAPY["sign_type"],  # RSA2
            debug = False,  # 默认False
        )
        return alipay

    def get(self,request):
        """发起支付"""
        order_number = request.query_params.get("order_number")
        try:
            order = Order.objects.get(order_number=order_number,user=request.user)
        except Order.DoesNotExist:
            return Response({"message":"对不起，当前订单不存在！"},status=status.HTTP_400_BAD_REQUEST)

        order_string = self.alipay().api_alipay_trade_page_pay(
            out_trade_no=order_number,             # 订单号
            total_amount=float(order.real_price),  # 订单总金额
            subject="购买课程",         # 订单标题
            return_url=settings.ALIAPY["return_url"],  # 同步回调地址
            notify_url=settings.ALIAPY["notify_url"]  # 异步回调地址
        )

        return Response(settings.ALIAPY["gateway_url"]+order_string)

from django.http.response import HttpResponse
class AlipayResultAPIView(APIView):
    def get(self,request):
        """同步回调通知处理"""
        # for rest_framework users
        data = request.query_params.dict()
        """
        {
            'charset': 'utf-8', 
            'out_trade_no': '20201014030343000000000110880223', 
            'method': 'alipay.trade.page.pay.return', 
            'total_amount': '159.20', 
            'sign': 'K8J6Psh448TfdbuP37IUiWSHUVH5wTS77B6LqAU5/3Q8/5h3OyWdVKnlzIG1XdFo5UoRDsdYlWM9FwAaHUYbayUpWiWjs3OMTNacl99s1syu+JTDCLui3KNnk7B0uCyjlR3dRTfBYPq4AkBOgeQVgWYm+zz3QP2roGPvQ0htiK+OV4rSu8DTDzirnfQIPG2ydI321SzwV8tDfDbcMU0pkT4t6OZjqL1VdBMj0qrnkoYmXaF8RAEeV+cnkbpzSCUGtoZ2s2U4dO1sYcJ1UVQkVaPFYB/SeExUFwovIh+rsuFXdXck2zaRutg8+Sy3aatgiadXwJFVmHDn5EsJJtlTrw==', 
            'trade_no': '2020101422001439880503110031', 
            'auth_app_id': '2016091600523592', 
            'version': '1.0', 
            'app_id': '2016091600523592', 
            'sign_type': 'RSA2', 
            'seller_id': '2088102175868026', 
            'timestamp': '2020-10-14 11:26:47'
        }
        """
        signature = data.pop("sign")

        # 验证结果
        success = AlipayAPIView.alipay().verify(data, signature)
        if success:
            # 完成订单的状态等相关信息处理
            try:
                order = Order.objects.get(order_number=data.get("out_trade_no"))
            except Order.DoesNotExist:
                return Response({"message":"当前订单不存在！"},status=status.HTTP_400_BAD_REQUEST)

            return self.orderhandler(order)

        return Response({"message":"订单支付结果发生异常！"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def post(self,request):
        """异步回调通知处理"""
        """
        异步回调通知接口在本地开发时是无法测试，因为当前开发机子处于局域网中，不是在公网。
        这意味着说，支付宝无法访问过来。因此，我们可以先把代码编写完成，等项目上线到公网服务器时进行测试。
        """
        data = request.data
        signature = data.pop("sign")

        # verification
        success = AlipayAPIView.alipay().verify(data, signature)
        if success and data["trade_status"] in ("TRADE_SUCCESS", "TRADE_FINISHED"):
            # 完成订单的状态等相关信息处理
            try:
                order = Order.objects.get(order_number=data.get("out_trade_no"))
            except Order.DoesNotExist:
                return Response({"message": "当前订单不存在！"}, status=status.HTTP_400_BAD_REQUEST)

            if order.order_status == 1:
                """表示当前订单的支付结果已经被处理完成了"""
                return HttpResponse('success')
            elif order.order_status == 0:
                """表示当前订单并没有被处理过，有可能同步通知处理有可能出异常或者被用户关闭界面了！"""
                response = self.orderhandler(order)
                if response.status_code == 200:
                    return HttpResponse('success')

        return HttpResponse('error')

    def orderhandler(self,order):
        # 修改订单的支付状态和支付时间
        if order.order_status == 0:
            # 修改状态
            with transaction.atomic():
                save_id = transaction.savepoint()
                try:
                    order.order_status = 1
                    order.pay_time = datetime.now()
                    order.save()

                    # 添加对应课程的学习人数
                    order_detail = order.order_courses.all()
                    course_list = []
                    for detail in order_detail:
                        detail.course.students += 1
                        detail.course.save()
                        # todo 记录每一个用户与课程之间的购买时间记录
                        # todo 1. 第一次购买当前课程
                        # todo 2. 以前购买过，已经过期
                        # todo 3. 以前购买过，还没过期

                        course_list.append({"course_id": detail.course.id, "course_name": detail.course.name})

                    order_info = {"pay_time": order.pay_time.timestamp(), "real_price": order.real_price,
                                  "course_list": course_list}

                    return Response(order_info)

                except:
                    transaction.savepoint_rollback(save_id)
                    return Response({"message": "订单修改状态过程中出现异常！"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

        elif order.order_status == 1:
            return Response({"message": "当前订单已经支付成功了!"}, status=status.HTTP_404_NOT_FOUND)
        else:
            return Response({"message": "当前订单发生未知异常!"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
