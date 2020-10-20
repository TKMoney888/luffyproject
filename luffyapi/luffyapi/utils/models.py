from django.db import models
from datetime import datetime
# Create your models here.

class BaseModel(models.Model):
    """
    基础抽象模型
    """
    name = models.CharField(max_length=150,default=None,null=True,blank=True, verbose_name='名称/标题')
    orders = models.IntegerField(default=0, verbose_name='显示顺序')
    is_show = models.BooleanField(default=True, verbose_name="是否上架")
    is_delete = models.BooleanField(default=False, verbose_name="逻辑删除",)
    created_time = models.DateTimeField(auto_now_add=datetime.now(), verbose_name="创建时间")
    updateed_time = models.DateTimeField(auto_now=datetime.now(), verbose_name="更新时间")

    class Meta:
        # 设置当前模型为抽象数据模型,django不会针对当前字段进行数据迁移
        abstract = True

    def __str__(self):
        return self.name