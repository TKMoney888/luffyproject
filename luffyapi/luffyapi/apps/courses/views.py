from django.shortcuts import render

# Create your views here.
# Create your views here.
from rest_framework.generics import ListAPIView
from .models import CourseCategory
from .serializers import CourseCategorySerializer
class CourseCategoryAPIView(ListAPIView):
    """课程分类列表"""
    queryset = CourseCategory.objects.filter(is_delete=False,is_show=True).order_by("-orders")
    serializer_class = CourseCategorySerializer

# Create your views here.
from rest_framework.generics import ListAPIView
from .models import Course
from .serializers import CourseSerializer
from django_filters.rest_framework import DjangoFilterBackend
from rest_framework.filters import OrderingFilter
from .paginations import CoursePagination
class CourseAPIView(ListAPIView):
    """课程列表接口"""
    filter_backends = [DjangoFilterBackend, OrderingFilter]
    filter_fields = ('course_category',)
    ordering_fields = ["id","price","students"]
    pagination_class = CoursePagination
    queryset = Course.objects.filter(is_delete=False, is_show=True).order_by("-orders")
    serializer_class = CourseSerializer

from rest_framework.generics import RetrieveAPIView
from .serializers import CourseRetrieveSerializer
class CourseRetrieveAPIView(RetrieveAPIView):
    """课程详情"""
    queryset = Course.objects.filter(is_delete=False, is_show=True)
    serializer_class = CourseRetrieveSerializer

from .models import CourseChapter
from .serializers import CourseChapterModelSerializer
class CourseChapterListAPIView(ListAPIView):
    queryset = CourseChapter.objects.filter(is_show=True, is_delete=False).order_by("number")
    serializer_class = CourseChapterModelSerializer
    filter_backends = [DjangoFilterBackend]
    filter_fields = ['course', ]

from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from luffyapi.libs.polyv import PolyvPlayer
from django.conf import settings
from rest_framework.response import Response
from rest_framework import status
class PolyvAPIView(APIView):
    permission_classes = [IsAuthenticated]
    def get(self, request):
        """获取视频播放的token"""
        player = PolyvPlayer(
            userId=settings.POLYV.get("userId"),
            secretkey=settings.POLYV.get("secretkey"),
            tokenUrl=settings.POLYV.get("tokenUrl")
        )
        vid = request.query_params.get("vid")
        user_ip = request._request.META.get("REMOTE_ADDR")
        user_id = request.user.id
        user_name = request.user.name if request.user.name else request.user.username
        try:
            token = player.get_video_token(videoId=vid,viewerIp=user_ip,viewerId=user_id,viewerName=user_name)
        except:
            return Response({"message":"无法获取当前视频的播放授权"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

        return Response(token)

class MyCourseChapterListAPIView(APIView):
    """课程播放详情的课时列表"""
    permission_classes = [IsAuthenticated]
    def get(self, request):
        course_id = request.query_params.get("course")
        # todo 先判断当前用户是否已经购买了当前课程.
        try:
            course = Course.objects.get(pk=course_id)
        except Course.DoesNotExist:
            return Response({"message":"当前课程不存在!"}, status=status.HTTP_400_BAD_REQUEST)

        # 获取当前课程的章节列表
        chapters = course.chapters.filter(is_show=True,is_delete=False).order_by("number")
        data = {
            "course_id": course.id,
            "course_name": course.name,
            "course_img": course.course_img.url,
            "children":[]
        }
        for chapter in chapters:
            data["children"].append({
                "id": chapter.id,
                "label": chapter.name,
                "children": chapter.lesson_list
            })

        return Response(data)