from rest_framework import serializers
from .models import UserCoupon,Coupon

class CouponModelSerializer(serializers.ModelSerializer):
    """优惠券序列化器"""
    class Meta:
        model = Coupon
        fields = ["name","coupon_type","duration","condition","sale","course_info"]

class UserCouponModelSerializer(serializers.ModelSerializer):
    """用户优惠券序列化器"""
    coupon = CouponModelSerializer()
    class Meta:
        model = UserCoupon
        fields = ["id","start_timestamp","end_timestamp","now_timestamp","coupon",]