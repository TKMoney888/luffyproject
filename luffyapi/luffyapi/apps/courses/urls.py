# 子应用路由
from django.urls import path,re_path
from . import views
urlpatterns = [
    path("category/",views.CourseCategoryAPIView.as_view()),
    path("", views.CourseAPIView.as_view()),
    re_path("^(?P<pk>\d+)/$", views.CourseRetrieveAPIView.as_view()),
    path("chapters/", views.CourseChapterListAPIView.as_view()),
    path("play/", views.PolyvAPIView.as_view()),
    path("chapters2/", views.MyCourseChapterListAPIView.as_view()),
]
