# Create your views here.
from rest_framework.generics import CreateAPIView
from .models import Order,OrderDetail
from .serializers import OrderModelSerializer
from rest_framework.permissions import IsAuthenticated
class OrderCreateAPIView(CreateAPIView):
    permission_classes = [IsAuthenticated]
    queryset = Order.objects.all()
    serializer_class = OrderModelSerializer

from rest_framework.generics import ListAPIView
from .serializers import OrderListModelSerializer
class OrderListAPIView(ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = OrderListModelSerializer
    queryset = Order.objects.all()

    def get_queryset(self):
        return Order.objects.filter(user=self.request.user).all()

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
class OrderCancelAPIView(APIView):
    permission_classes = [IsAuthenticated]
    def patch(self,request):
        """取消订单"""
        order_number = request.data.get("order_number")
        try:
            order = Order.objects.get(order_status=0, user=request.user,order_number=order_number)
        except Order.DoesNotExist:
            return Response({"message":"对不起，订单不存在！"}, status=status.HTTP_400_BAD_REQUEST)

        order.order_status = 2
        order.save()
        return Response({"message":"取消订单成功！"})
