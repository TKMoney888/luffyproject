from django.db import models
from luffyapi.utils.models import BaseModel
from django.utils import timezone as datetime
# Create your models here.
class CourseCategory(BaseModel):
    """
    课程分类
    """
    class Meta:
        db_table = "ly_course_category"
        verbose_name = "课程分类"
        verbose_name_plural = "课程分类"

from luffyapi.settings import constants
from ckeditor_uploader.fields import RichTextUploadingField
class Course(BaseModel):
    """
    实战课程
    """
    course_type = (
        (0, '付费'),
        (1, 'VIP专享'),
        (2, '学位课程'),
    )
    level_choices = (
        (0, '初级'),
        (1, '中级'),
        (2, '高级'),
    )
    status_choices = (
        (0, '上线'),
        (1, '下线'),
        (2, '预上线'),
    )
    course_img = models.ImageField(upload_to="course", max_length=255, verbose_name="封面图片", blank=True, null=True)
    course_video = models.FileField(upload_to="course_video", max_length=255, verbose_name="封面视频", blank=True, null=True)
    course_type = models.SmallIntegerField(choices=course_type,default=0, verbose_name="付费类型")
    #
    brief = RichTextUploadingField(verbose_name="详情介绍", null=True, blank=True)
    level = models.SmallIntegerField(choices=level_choices, default=1, verbose_name="难度等级")
    pub_date = models.DateField(verbose_name="发布日期", auto_now_add=True)
    period = models.IntegerField(verbose_name="建议学习周期(day)", default=7)
    attachment_path = models.FileField(max_length=128, verbose_name="课件路径", blank=True, null=True)
    status = models.SmallIntegerField(choices=status_choices, default=0, verbose_name="课程状态")
    course_category = models.ForeignKey("CourseCategory", on_delete=models.DO_NOTHING, null=True, blank=True,verbose_name="课程分类")
    students = models.IntegerField(verbose_name="学习人数",default = 0)
    lessons = models.IntegerField(verbose_name="总课时数量",default = 0)
    pub_lessons = models.IntegerField(verbose_name="课时更新数量",default = 0)
    price = models.DecimalField(max_digits=6,decimal_places=2, verbose_name="课程原价",help_text="此处填写价格属于永久购买价格,如果没有<b style='color: red;'>永久购买</b>期限,则默认价格为0,请不要随意删除",default=0)
    teacher = models.ForeignKey("Teacher",on_delete=models.DO_NOTHING, null=True, blank=True,verbose_name="授课老师")
    class Meta:
        db_table = "ly_course"
        verbose_name = "实战课程"
        verbose_name_plural = "实战课程"

    @property
    def recomment_lesson_list(self):
        lesson_list = self.lesson_list.filter(is_delete=False,is_show=True,recomment=True).order_by("-orders").all()[:constants.RECOMMEND_LESSON_SIZE]
        data_list = [{"id":lesson.id,"name":lesson.name,"free_trail": lesson.free_trail,"number":lesson.number} for lesson in lesson_list]
        return data_list

    @property
    def level_name(self):
        return self.get_level_display()

    def get_price(self,expire):
        """根据有效期选项获取价格"""
        price = 0
        if expire == "-1":
            price = "%.2f" % self.price
        else:
            ret = self.course2expire.filter(is_show=True,is_delete=False, time=expire)
            if len(ret) > 0:
                price = ret[0].price

        # 如果当前商品有参加到活动中, 则计算返回活动价格
        # price = float( self.discount_price(price) )
        return price

    @property
    def min_expire(self):
        ret = self.course2expire.filter(is_show=True, is_delete=False).order_by("time")[:1]
        if len(ret) > 0:
            return ret[0].time
        else:
            return -1

    @property
    def expire_list(self):
        data_list = self.course2expire.filter(is_show=True, is_delete=False).order_by("time")
        data = [{
            "id": item.id,
            "time":item.time,
            "name":item.name,
            "price": item.price,
            "discount_price": self.discount_price(item.price),
        } for item in data_list]
        # 判断当前课程是否存在永久购买的选项
        if self.price > 0:
            data.append({
                "id": 0,
                "time":-1,
                "name": "永久有效",
                "price": self.price,
                "discount_price": self.discount_price(self.price),
            })
        return data

    @property
    def discount_name(self):
        # 从时间上是否有活动正在进行
        activity_list = self.course_activity.filter(activity__start_time__lte=datetime.now(), activity__end_time__gte=datetime.now(),is_show=True,is_delete=False).order_by("activity__start_time")
        if len(activity_list) > 0:
            return activity_list[0].discount.discount_type.name
        else:
            return ""

    def discount_price(self,expire_price=None):
        # 最终优惠价格
        sale_price = 0

        # 默认商品原价
        if expire_price is None:
            min_price = self.min_price
        else:
            min_price = float(expire_price)

        if self.discount_name:
            # 判断折扣类型
            activity_list = self.course_activity.filter(activity__start_time__lte=datetime.now(), activity__end_time__gte=datetime.now(),is_show=True,is_delete=False).order_by("activity__start_time")[:1]
            activity_discount = activity_list[0]

            # 判断当前是否符合优惠的要求
            if activity_discount.discount.condition > min_price:
                return "%.2f" % min_price

            # 获取公式
            sale = activity_discount.discount.sale
            if sale[0] == "*":
                """限时折扣"""
                sale_price = min_price * float(sale[1:])
            elif sale[0] == "-":
                """限时减免"""
                sale_price = min_price - float(sale[1:])
            elif sale[0] == "满":
                """限时满减"""
                sale_list = sale.split("\n")
                discount_list = []
                for sale_item in sale_list:
                    sale_condition,sale_value = sale_item.split("-")
                    condition = float(sale_condition[1:])
                    value = float(sale_value)
                    if condition < min_price:
                        discount_list.append(value)

                sale_price = min_price - max(discount_list)

            elif sale == "0":
                """限时免费"""
                sale_price = 0
        else:
            sale_price = min_price

        return "%.2f" % sale_price

    @property
    def min_price(self):
        if len(self.expire_list)>0:
            price = self.expire_list[0].get("price")
        else:
            price = self.price
        return float(price)

    @property
    def activity_end_time(self):
        time = 0
        activity_list = self.course_activity.filter(activity__start_time__lte=datetime.now(),
                                                    activity__end_time__gte=datetime.now(), is_show=True,
                                                    is_delete=False).order_by("activity__start_time")
        if len(activity_list) > 0:
            end_timestamp = activity_list[0].activity.end_time.timestamp()
            now_timestamp = datetime.now().timestamp()
            time = end_timestamp - now_timestamp
        return int(time)

    def expire_text(self,expire):
        """有效期选项的名称"""
        text = "永久有效"
        try:
            course_expire = CourseExpire.objects.get(course=self, time=expire)
            text = course_expire.name
        except:
            pass
        return text

class Teacher(BaseModel):
    """讲师、导师表"""
    role_choices = (
        (0, '讲师'),
        (1, '导师'),
        (2, '班主任'),
    )
    role = models.SmallIntegerField(choices=role_choices, default=0, verbose_name="讲师身份")
    title = models.CharField(max_length=64, verbose_name="职位、职称")
    signature = models.CharField(max_length=255, verbose_name="导师标签签名", help_text="导师标签签名", blank=True, null=True)
    image = models.ImageField(upload_to="teacher", null=True, verbose_name = "讲师封面")
    brief = models.TextField(max_length=1024, verbose_name="讲师描述")

    class Meta:
        db_table = "ly_teacher"
        verbose_name = "讲师导师"
        verbose_name_plural = "讲师导师"

class CourseChapter(BaseModel):
    """课程章节"""
    course = models.ForeignKey("Course", related_name='chapters', on_delete=models.CASCADE, verbose_name="课程名称")
    number = models.SmallIntegerField(verbose_name="章节序号", default=1)
    summary = models.TextField(verbose_name="章节介绍", blank=True, null=True)
    pub_date = models.DateField(verbose_name="发布日期", auto_now_add=True)

    class Meta:
        db_table = "ly_course_chapter"
        verbose_name = "课程章节"
        verbose_name_plural = "课程章节"

    def __str__(self):
        return "课程:%s-第%s章-%s" % (self.course, self.number, self.name)

    @property
    def lesson_list(self):
        lesson_list = self.lessons.filter(is_delete=False,is_show=True).order_by("number").all()
        data_list = [{
            "id":lesson.id,
            "name":lesson.name,
            "label":lesson.name,
            "free_trail": lesson.free_trail,
            "number":lesson.number,
            "lesson_type": lesson.lesson_type,
            "lesson_link": lesson.lesson_link,
            "duration": lesson.duration
        } for lesson in lesson_list]

        return data_list


class CourseLesson(BaseModel):
    """课程课时"""
    lesson_type_choices = (
        (0, '文档'),
        (1, '练习'),
        (2, '视频')
    )
    chapter = models.ForeignKey("CourseChapter", related_name='lessons', on_delete=models.CASCADE, verbose_name="章节")
    course = models.ForeignKey("Course", related_name="lesson_list", on_delete=models.CASCADE, verbose_name="课程")
    lesson_type = models.SmallIntegerField(default=2, choices=lesson_type_choices, verbose_name="课时种类")
    lesson_link = models.CharField(max_length=255, blank=True, null=True, verbose_name="课时链接",
                                   help_text="若是video，填vid,若是文档，填link")
    duration = models.CharField(verbose_name="视频时长", blank=True, null=True, max_length=32)  # 仅在前端展示使用
    pub_date = models.DateTimeField(verbose_name="发布时间", auto_now_add=True)
    free_trail = models.BooleanField(verbose_name="是否可试看", default=False)
    recomment = models.BooleanField(verbose_name="是否推荐到课程列表")
    number = models.IntegerField(default=1,verbose_name="课时序号")
    class Meta:
        db_table = "ly_course_lesson"
        verbose_name = "课程课时"
        verbose_name_plural = "课程课时"

    def __str__(self):
        return "%s-第%s节-%s" % (self.chapter, self.number,self.name)

class CourseExpire(BaseModel):
    name = models.CharField(max_length=150, default=None, null=True, blank=True, verbose_name='课程有效期(天)',help_text="例如: 1个月有效")
    course = models.ForeignKey("Course", related_name='course2expire', on_delete=models.CASCADE, verbose_name="课程ID")
    time = models.IntegerField(verbose_name="课程有效期(天)",help_text="例如: 30")
    price  = models.DecimalField(max_digits=8,decimal_places=2, verbose_name="课程价格",default=0)

    class Meta:
        db_table = "ly_course_expire"
        verbose_name = "课程与有效期"
        verbose_name_plural = verbose_name
    def __str__(self):
        return "%s" % (self.course)

class CourseDiscountType(BaseModel):
    """课程优惠类型"""
    remark = models.CharField(max_length=250,blank=True, null=True, verbose_name="备注信息")

    class Meta:
        db_table = "ly_course_discount_type"
        verbose_name = "课程优惠类型"
        verbose_name_plural = "课程优惠类型"


class CourseDiscount(BaseModel):
    """课程价格优惠"""
    discount_type = models.ForeignKey("CourseDiscountType", on_delete=models.CASCADE, related_name='discounts', verbose_name="优惠类型")
    condition = models.IntegerField(blank=True, default=0, verbose_name="满足优惠的价格条件", help_text="设置享受优惠的价格条件,如果没有条件则默认为0即可")
    sale = models.TextField(verbose_name="优惠公式", help_text="""
    0表示免费；<br>
    *号开头表示折扣价，例如填写*0.82,则表示八二折；<br>
    -号开头表示减免价, 例如填写-100,则表示减免100；<br>
    表示满减,则需要使用 原价-优惠价格,例如表示,课程价格大于100,优惠10;大于200,优惠20,格式如下:<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;满100-10<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;满200-20<br>
    """)

    class Meta:
        db_table = "ly_course_discount"
        verbose_name = "课程优惠策略"
        verbose_name_plural = "课程优惠策略"

    def __str__(self):
        return "价格优惠:%s,优惠条件:%s,优惠值:%s" % (self.discount_type.name, self.condition, self.sale)

class Activity(BaseModel):
    """优惠活动记录"""
    start_time = models.DateTimeField(default=datetime.now(), verbose_name="开始时间")
    end_time = models.DateTimeField(default=datetime.now(), verbose_name="结束时间")

    class Meta:
        db_table = "ly_activity"
        verbose_name = "活动记录表"
        verbose_name_plural = "活动记录表"

class ActivityDiscount(BaseModel):
    """课程活动价格表"""
    activity = models.ForeignKey("Activity", on_delete=models.CASCADE, related_name='activity_course',
                                 verbose_name="活动")
    course = models.ForeignKey("Course", on_delete=models.CASCADE, related_name='course_activity',
                               verbose_name="课程")
    discount = models.ForeignKey("CourseDiscount", on_delete=models.CASCADE, related_name='discount_activity',
                               verbose_name="优惠")

    class Meta:
        db_table = "ly_activity_discount"
        verbose_name = "课程活动价格表"
        verbose_name_plural = "课程活动价格表"

    def __str__(self):
        return "活动:%s-课程:%s-优惠值:%s" % (self.activity.name, self.course.name, self.discount.sale)
