from rest_framework import serializers
from .models import CourseCategory
class CourseCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = CourseCategory
        fields = ["id","name"]

from .models import Course,Teacher
class TeacherModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Teacher
        fields = ["id","name","role","title","signature","image","brief"]

# from .models import CourseLesson
# class CourseLessonModelSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = CourseLesson
#         fields = ("id","name","free_trail")

class CourseSerializer(serializers.ModelSerializer):
    teacher = TeacherModelSerializer()
    # lesson_list = CourseLessonModelSerializer(many=True)
    class Meta:
        model = Course
        # fields = ["id","name","course_img","students","lessons","pub_lessons","price","teacher","lesson_list"]
        fields = ["id","name","course_img","students","discount_name","discount_price","lessons","pub_lessons","min_price", "teacher","recomment_lesson_list"]


class CourseRetrieveSerializer(serializers.ModelSerializer):
    """课程详情"""
    teacher = TeacherModelSerializer()
    class Meta:
        model = Course
        fields = ["id","name","course_img","course_video","students","lessons","pub_lessons","min_price","teacher","brief","level_name","pub_date","discount_name","discount_price","activity_end_time"]

from .models import CourseChapter
class CourseChapterModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = CourseChapter
        fields = ["id", "number", "name", "summary", "lesson_list"]