from luffyapi.utils.models import BaseModel,models
class Banner(BaseModel):
    """轮播图模型"""
    """
    轮播图
    """
    # upload_to 存储子目录，真实存放地址会使用配置中的MADIE_ROOT+upload_to
    image = models.ImageField(upload_to='banner', null=True,blank=True, verbose_name='轮播图')
    note = models.CharField(max_length=150, verbose_name='备注信息')
    link = models.CharField(max_length=150, verbose_name='轮播图广告地址')
    class Meta:
        db_table = 'ly_banner'
        verbose_name = '轮播图'
        verbose_name_plural = verbose_name

class Nav(BaseModel):
    """导航视图"""
    NAV_POSITION = (
        (0, '头部导航'),
        (1, '脚部导航')
    )
    link = models.CharField(max_length=250, verbose_name='导航地址', help_text="如果是站外导航,则需要写上完整链接地址,例如:http://www.luffycity.cn<br>如果是站内地址,则可以直接写上路径不需要加上协议域名,例如: /courses")
    opt = models.SmallIntegerField(choices=NAV_POSITION, default=0, verbose_name='导航位置')
    is_http = models.BooleanField(default=False,  verbose_name="是否属于站外链接")

    class Meta:
        db_table = 'ly_nav'
        verbose_name = '导航'
        verbose_name_plural = verbose_name
