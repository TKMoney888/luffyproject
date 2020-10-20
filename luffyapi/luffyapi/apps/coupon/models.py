from django.db import models
from luffyapi.utils.models import BaseModel
from django.utils import timezone as datetime
from courses.models import Course
# Create your models here.
class Coupon(BaseModel):
    """优惠券类型"""
    coupon_choices = (
        (1, '减免优惠'),
        (2, '折扣优惠'),
    )
    method_choices = (
        (1, '系统赠送'),
        (2, '用户中心领取'),
        (3, '注册赠送'),
    )
    coupon_type = models.SmallIntegerField(choices=coupon_choices, default=1, verbose_name="优惠类型",help_text="优惠类型分2种:<br>1. 减免优惠,需要设置优惠券使用条件,用户使用过程中, 针对订单进行减免.<br>2. 折扣优惠, 只针对指定的商品有效, 需要设置优惠券关联的商品,否则发放以后用户无法使用.")
    duration = models.IntegerField(verbose_name="优惠券有效期", default=7, help_text="优惠券有效期(天), 默认7天有效.")
    condition = models.IntegerField(blank=True, default=0, verbose_name="优惠券使用的价格条件")
    course = models.ForeignKey(Course, related_name="course_coupon", null=True, blank=True, on_delete=models.CASCADE,verbose_name="关联课程")
    number = models.IntegerField(default=100, verbose_name="发放数量",)
    method = models.SmallIntegerField(choices=method_choices, default=1, verbose_name="发放方式")
    sale = models.TextField(verbose_name="优惠公式", help_text="""
        *号开头表示折扣优惠，例如*0.82表示针对商品进行八二折；<br>
        -号开头表示减免优惠, 例如-10表示在总价基础上减免10元<br>   
        """)
    class Meta:
        db_table = "ly_coupon"
        verbose_name = "优惠券类型"
        verbose_name_plural = "优惠券类型"

    def __str__(self):
        if self.coupon_type == 1:
            return "%s[满%s元可以使用]" % (self.name,self.condition)
        else:
            return "%s[购买课程<%s>可以使用]" % (self.name,self.course.name)

    @property
    def course_info(self):
        return {
            "course_id": self.course.id,
            "course_name": self.course.name,
        }

from users.models import User
class UserCoupon(BaseModel):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="coupons", verbose_name="用户")
    coupon = models.ForeignKey(Coupon, on_delete=models.CASCADE, related_name="users", verbose_name="优惠券")
    start_time = models.DateTimeField(default=datetime.now(),verbose_name="优惠券的启用时间")
    is_use = models.BooleanField(default=False,verbose_name="优惠券是否使用过")

    class Meta:
        db_table = "ly_user_coupon"
        verbose_name = "用户的优惠券"
        verbose_name_plural = "用户的优惠券"

    def __str__(self):
        return "优惠券:%s,用户:%s" % (self.coupon.name, self.user.username)

    @property
    def start_timestamp(self):
        """开始使用时间"""
        return int(self.start_time.timestamp())

    @property
    def end_timestamp(self):
        """过期时间"""
        return int(self.start_timestamp + self.coupon.duration * 24 * 60 * 60)

    @property
    def now_timestamp(self):
        """服务端当前时间"""
        return int(datetime.now().timestamp())