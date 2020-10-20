from django.db import models
from luffyapi.settings import constants
# Create your models here.
from django.contrib.auth.models import AbstractUser
from luffyapi.utils.models import BaseModel
from courses.models import Course
class User(AbstractUser,BaseModel):
    """自定义用户模型"""
    name     = models.CharField(max_length=150,default=None,null=True,blank=True, verbose_name='用户昵称')
    avatar   = models.ImageField(upload_to="avatar", null=True, blank=True, verbose_name="头像")
    mobile   = models.CharField(max_length=20, unique=True, verbose_name="手机号")
    birthday = models.DateTimeField(null=True, blank=True, verbose_name="出生日期")
    money    = models.DecimalField(max_digits=10,default=0.0, decimal_places=2, verbose_name="资金余额")
    credit   = models.IntegerField(default=0, null=True, blank=True, verbose_name="用户积分",
                                 help_text="用户积分换算比例： 1RMB=%s积分" % constants.RMB_CREDIT)
    class Meta:
        db_table = 'ly_users'
        verbose_name = '用户'
        verbose_name_plural = verbose_name

class Credit(BaseModel):
    """积分流水模型"""
    opera_choices = (
        (0, "业务充值"),
        (1, "购物消费"),
        (2, "系统赠送"),
    )
    operation = models.SmallIntegerField(choices=opera_choices, default=1,verbose_name="积分操作类型")
    number = models.IntegerField(default=0, verbose_name="积分数量",help_text="如果是扣除积分则需要设置积分为负数，如果消费10积分，则填写-10，<br>如果是添加积分则需要设置积分为正数，如果获得10积分，则填写10。")
    user   = models.ForeignKey(User, related_name='user_credits', on_delete=models.CASCADE,verbose_name="用户")
    remark = models.CharField(max_length=500, null=True,blank=True, verbose_name="备注信息")

    class Meta:
        db_table = 'ly_credit'
        verbose_name = '积分'
        verbose_name_plural = verbose_name

    def __str__(self):
        if self.number > 0:
            oper_text = "获得"
        else:
            oper_text = "减少"
        return "[%s]%s%s%s积分" % (self.get_operation_display(),self.user.name, oper_text, abs(self.number))

class UserCourse(BaseModel):
    """用户的课程购买记录"""
    user   = models.ForeignKey(User, related_name='user2courses', on_delete=models.CASCADE,verbose_name="用户")
    course = models.ForeignKey(Course, related_name='course2users', on_delete=models.CASCADE, verbose_name="课程名称")
    last_time = models.DateTimeField(verbose_name="最近一次购买时间")
    has_time = models.DateTimeField(verbose_name="购买过期时间")

    class Meta:
        db_table = 'ly_user_course'
        verbose_name = '用户课程购买记录'
        verbose_name_plural = verbose_name