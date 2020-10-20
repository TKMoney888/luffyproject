from rest_framework_jwt.serializers import JSONWebTokenSerializer
from rest_framework import serializers
from rest_framework_jwt.compat import get_username_field, PasswordField
from django.contrib.auth import authenticate, get_user_model
from django.utils.translation import ugettext as _
from rest_framework_jwt.compat import get_username_field, PasswordField


User = get_user_model()
from rest_framework_jwt.settings import api_settings
jwt_payload_handler = api_settings.JWT_PAYLOAD_HANDLER
jwt_encode_handler = api_settings.JWT_ENCODE_HANDLER
jwt_decode_handler = api_settings.JWT_DECODE_HANDLER
jwt_get_username_from_payload = api_settings.JWT_PAYLOAD_GET_USERNAME_HANDLER

class CurtomJSONWebTokenSerializer(JSONWebTokenSerializer):
    """自定义的jwt序列化器"""
    def __init__(self, *args, **kwargs):
        """
        Dynamically add the USERNAME_FIELD to self.fields.
        """
        super(JSONWebTokenSerializer, self).__init__(*args, **kwargs)

        self.fields[self.username_field] = serializers.CharField()
        self.fields['password'] = PasswordField(write_only=True)
        self.fields['ticket'] = serializers.CharField(write_only=True)
        self.fields['randstr'] = serializers.CharField(write_only=True)
    def validate(self, attrs):
        credentials = {
            self.username_field: attrs.get(self.username_field),
            'password': attrs.get('password'),
            'ticket': attrs.get('ticket'),
            'randstr': attrs.get('randstr'),
        }

        if all(credentials.values()):
            user = authenticate(self.context["request"],**credentials)

            if user:
                if not user.is_active:
                    msg = _('User account is disabled.')
                    raise serializers.ValidationError(msg)

                payload = jwt_payload_handler(user)

                return {
                    'token': jwt_encode_handler(payload),
                    'user': user
                }
            else:
                msg = _('Unable to log in with provided credentials.')
                raise serializers.ValidationError(msg)
        else:
            msg = _('Must include "{username_field}" and "password".')
            msg = msg.format(username_field=self.username_field)
            raise serializers.ValidationError(msg)


import re,random
from datetime import datetime
from .models import User
from django_redis import get_redis_connection

from rest_framework_jwt.settings import api_settings
class UserModelSerializer(serializers.ModelSerializer):
    password2 = serializers.CharField(required=True, write_only=True, max_length=16, min_length=6, help_text="确认密码",label="确认密码")
    sms_code  = serializers.CharField(required=True, write_only=True, max_length=6, min_length=6, help_text="短信验证码", label="短信验证码")
    token     = serializers.CharField(read_only=True, label="jwt", help_text="jwt")
    class Meta:
        model = User
        fields = ["id","mobile","password","name","avatar","password2","sms_code","token"]
        extra_kwargs = {
            "mobile":{"write_only":True},
            "password":{"write_only":True},
            "name":{"read_only":True},
            "avatar":{"read_only":True},
        }

    def validate(self, attrs):
        # 接受数据
        password  = attrs.get("password")
        password2 = attrs.get("password2")
        mobile    = attrs.get("mobile")
        sms_code  = attrs.get("sms_code")

        # 验证
        if password != password2:
            raise serializers.ValidationError("密码和确认密码不一致!")

        if not re.match(r'^(\+86)?0?1[3-9]\d{9}$',mobile):
            raise serializers.ValidationError("手机号格式不正确!")

        try:
            User.objects.get(mobile=mobile)
            raise serializers.ValidationError("当前手机已注册!")
        except User.DoesNotExist:
            pass

        redis = get_redis_connection("sms_code")
        redis_sms_code_bytes = redis.get("sms_%s" % mobile)
        if redis_sms_code_bytes is None:
            raise serializers.ValidationError("短信验证已过期!请重新发送验证!")

        redis_sms_code = redis_sms_code_bytes.decode()
        if redis_sms_code != sms_code:
            raise serializers.ValidationError("短信错误,验证失败!请重新确认!~")
        # 及时删除一些不必要的验证数据,是开发中一个常见的习惯!
        redis.delete("sms_%s" % mobile )
        return attrs

    def create(self, validated_data):
        """保存用户信息"""
        validated_data.pop("sms_code")
        validated_data.pop("password2")
        try:
            # 生成随机账号
            username = "ly_" + hex(int(str(datetime.now().timestamp())[1:10] + '%04d' % random.randint(1, 9999)))[2:]
            user = User.objects.create_user(
                username=username,
                name=username,
                password=validated_data.get("password"),
                mobile=validated_data.get("mobile")
            )
            # 手动生成jwt登录状态
            jwt_payload_handler = api_settings.JWT_PAYLOAD_HANDLER
            jwt_encode_handler = api_settings.JWT_ENCODE_HANDLER
            payload = jwt_payload_handler(user)
            user.token = jwt_encode_handler(payload)

            return user

        except:
            raise serializers.ValidationError("用户注册失败!")