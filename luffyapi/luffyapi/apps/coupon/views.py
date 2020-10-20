from rest_framework.generics import ListAPIView
from .models import UserCoupon
from .serializers import UserCouponModelSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.permissions import IsAuthenticated
class UserCouponListAPIView(ListAPIView):
    """用户优惠券"""
    queryset = UserCoupon.objects.filter(is_delete=False,is_show=True)
    serializer_class = UserCouponModelSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [DjangoFilterBackend]
    filter_fields = ['user_id','is_use']

    # def get_queryset(self):
    #     # 如果希望登录用户只能查看自己的优惠券,则使用当前get_queryset方法重写
    #     return UserCoupon.objects.filter(user=self.request.user,is_delete=False,is_show=True)