from rest_framework_jwt.views import ObtainJSONWebToken
from .serializers import CurtomJSONWebTokenSerializer
# Create your views here.
class ObtainAPIView(ObtainJSONWebToken):
    serializer_class = CurtomJSONWebTokenSerializer


from rest_framework.views import APIView
from ronglian_sms_sdk import SmsSDK
from django.conf import settings
import random,json
from luffyapi.settings import constants
from rest_framework.response import Response
from django_redis import get_redis_connection
from rest_framework import status
from rest_framework.throttling import ScopedRateThrottle
from mycelery.sms.tasks import send_sms

class SendSMSAPIView(APIView):
    throttle_classes = [ScopedRateThrottle]
    throttle_scope = 'sms'
    def get(self,request,mobile):
        """获取短信验证码"""
        # 判断是否处于发送短信冷却时间内
        redis = get_redis_connection("sms_code")
        interval_time = redis.ttl("interval_%s" % mobile)
        if interval_time >= 0:
            return Response({"message":"短信已发送,请%s秒后再点击发送" % interval_time}, status=status.HTTP_403_FORBIDDEN)

        code = "%06d" % random.randint(0, 999999)
        # 异步调用任务,send_sms是被装饰过的任务对象,并非普通函数
        ret = send_sms.delay(mobile,code) # delay会把任务添加到队列中
        # ret是一个任务结果对象,直接使用就是任务ID,将来可以通过任务ID直接到结果队列中读取任务执行的结果

        # 记录短信验证码到redis中
        pipe = redis.pipeline(0) # 创建一个管道对象
        pipe.multi() # 开启事务
        pipe.setex("sms_%s" % mobile, constants.SMS_EXPIRE_TIME, code)
        pipe.setex("interval_%s" % mobile, constants.SMS_INTERVAL_TIME, "_")
        pipe.execute() # 执行事务,在pipe内缓存的所有命令会一并提交,要么一起成功,要么一起失败!

        return Response({"message":"短信发送中, 稍后请留意您的手机及时查看短信."})

from rest_framework.generics import CreateAPIView
from .models import User
from .serializers import UserModelSerializer
class UserAPIView(CreateAPIView):
    queryset = User.objects.all()
    serializer_class = UserModelSerializer