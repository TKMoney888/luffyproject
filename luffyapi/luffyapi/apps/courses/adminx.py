import xadmin
from .models import CourseCategory
class CourseCategoryModelAdmin(object):
    """课程分类模型管理类"""
    pass
xadmin.site.register(CourseCategory, CourseCategoryModelAdmin)


from .models import Course
class CourseModelAdmin(object):
    """课程模型管理类"""
    pass
xadmin.site.register(Course, CourseModelAdmin)


from .models import Teacher
class TeacherModelAdmin(object):
    """老师模型管理类"""
    pass
xadmin.site.register(Teacher, TeacherModelAdmin)


from .models import CourseChapter
class CourseChapterModelAdmin(object):
    """课程章节模型管理类"""
    pass
xadmin.site.register(CourseChapter, CourseChapterModelAdmin)

from .models import CourseLesson
class CourseLessonModelAdmin(object):
    """课程课时模型管理类"""
    pass
xadmin.site.register(CourseLesson, CourseLessonModelAdmin)

from .models import CourseExpire
class CourseExpireModelAdmin(object):
    """课程与有效期模型管理类"""
    list_display = ["course","name","time","price"]
xadmin.site.register(CourseExpire, CourseExpireModelAdmin)


from .models import CourseDiscountType
class CourseDiscountTypeModelAdmin(object):
    """课程优惠类型"""
    list_display = ["id","name","remark"]
xadmin.site.register(CourseDiscountType, CourseDiscountTypeModelAdmin)

from .models import CourseDiscount
class CourseDiscountModelAdmin(object):
    """课程优惠类型"""
    list_display = ["id","name","discount_type","condition","sale"]
xadmin.site.register(CourseDiscount, CourseDiscountModelAdmin)

from .models import Activity
class ActivityModelAdmin(object):
    """优惠活动记录"""
    list_display = ["id","name","start_time","end_time"]
xadmin.site.register(Activity, ActivityModelAdmin)

from .models import ActivityDiscount
from xadmin.layout import Fieldset
class ActivityDiscountModelAdmin(object):
    """优惠活动记录"""
    list_display = ["id","activity","course","discount"]
    form_layout = (
        Fieldset("必填项", 'activity','course','discount'),
        Fieldset("可选项", 'orders','is_show','is_delete'),
        Fieldset(None, 'name',**{"style":"display:none;"} ),
    )
xadmin.site.register(ActivityDiscount, ActivityDiscountModelAdmin)