from django.urls import path,re_path
from rest_framework_jwt.views import obtain_jwt_token,verify_jwt_token
from . import views
urlpatterns = [
    path('login/', views.ObtainAPIView.as_view()),
    path('verify/', verify_jwt_token),
    re_path('sms/(?P<mobile>1[3-9]\d{9})/', views.SendSMSAPIView.as_view()),
    path('', views.UserAPIView.as_view()),
]
