"""
Django settings for luffyapi project.

Generated by 'django-admin startproject' using Django 3.1.1.

For more information on this file, see
https://docs.djangoproject.com/en/3.1/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/3.1/ref/settings/
"""

from pathlib import Path
import os

# Build paths inside the project like this: BASE_DIR / 'subdir'.
# print(Path(__file__).resolve().parent.parent) # 项目的主应用目录
BASE_DIR = Path(__file__).resolve().parent.parent
import sys
sys.path.insert(0,os.path.join(BASE_DIR,"apps"))

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/3.1/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '+=j^8dh#j*#^p+5#)@gz**@!lqnpt^%@%98(0jkm5%sn6yomvu'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = False

ALLOWED_HOSTS = ["api.ipython.top","127.0.0.1","47.114.51.135"]


# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    'rest_framework',
    'corsheaders',
    'xadmin',
    'crispy_forms',
    'reversion',
    'django_filters',  # 需要注册应用，
    'ckeditor',  # 富文本编辑器
    'ckeditor_uploader',  # 富文本编辑器上传图片模块

    'home',
    'users',
    'courses',
    'cart',
    'orders',
    'coupon',
    'payments',
]

# CORS组的配置信息
CORS_ORIGIN_WHITELIST = (
    'http://3w.ipython.top',
)
# 允许ajax跨域请求时携带cookie
CORS_ALLOW_CREDENTIALS = False

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'luffyapi.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'luffyapi.wsgi.application'


# Database
# https://docs.djangoproject.com/en/3.1/ref/settings/#databases

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.mysql",
        "HOST": "47.114.51.135",
        "PORT": 3306,
        "USER": "root",
        "PASSWORD": "123456",
        "NAME": "luffy",
    }
}

CACHES = {
    # 默认缓存
    "default": {
        "BACKEND": "django_redis.cache.RedisCache",
        # 项目上线时,需要调整这里的路径
        "LOCATION": "redis://47.114.51.135:6379/0",
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    },
    # 提供给xadmin或者admin的session存储
    "session": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://47.114.51.135:6379/1",
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    },
    # 提供存储短信验证码
    "sms_code":{
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://47.114.51.135:6379/2",
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    },
    "cart": {
        "BACKEND": "django_redis.cache.RedisCache",
        "LOCATION": "redis://47.114.51.135:6379/3",
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    },
}

# 设置xadmin用户登录时,登录信息session保存到redis
SESSION_ENGINE = "django.contrib.sessions.backends.cache"
SESSION_CACHE_ALIAS = "session"


# Password validation
# https://docs.djangoproject.com/en/3.1/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/3.1/topics/i18n/

# 修改使用中文界面
LANGUAGE_CODE = 'zh-Hans'

# 修改时区
TIME_ZONE = 'Asia/Shanghai'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.1/howto/static-files/

STATIC_URL = '/static/'
# 设置django的静态文件目录
STATICFILES_DIRS = [
    os.path.join(BASE_DIR,"static")
]
# 项目中存储上传文件的根目录[暂时配置]，注意，uploads目录需要手动创建否则上传文件时报错
MEDIA_ROOT=os.path.join(BASE_DIR,"uploads")
# 访问上传文件的url地址前缀
MEDIA_URL ="/media/"

# 日志配置
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': { # 日志的处理格式
        'verbose': {
            'format': '%(levelname)s %(asctime)s %(module)s %(lineno)d %(message)s'
        },
        'simple': {
            'format': '%(levelname)s %(module)s %(lineno)d %(message)s'
        },
    },
    'filters': {
        'require_debug_true': {
            '()': 'django.utils.log.RequireDebugTrue',
        },
    },
    'handlers': {
        'console': {
            'level': 'DEBUG',
            'filters': ['require_debug_true'],
            'class': 'logging.StreamHandler',
            'formatter': 'simple'
        },
        'file': {
            'level': 'INFO',
            'class': 'logging.handlers.RotatingFileHandler',
            # 日志位置,日志文件名,日志保存目录必须手动创建
            'filename': os.path.join(os.path.dirname(BASE_DIR), "logs/luffy.log"),
            # 单个日志文件的最大值,这里我们设置300M
            'maxBytes': 300 * 1024 * 1024,
            # 备份日志文件的数量,设置最大日志数量为10
            'backupCount': 10,
            # 日志格式:详细格式
            'formatter': 'verbose'
        },
    },
    # 日志对象
    'loggers': {
        'django': { # 固定，将来django内部也会有异常的处理，只会调用django下标的日志对象
            'handlers': ['console', 'file'],
            'propagate': True, # 是否让日志信息继续冒泡给其他的日志处理系统
        },
    }
}


REST_FRAMEWORK = {
    # 异常处理
    'EXCEPTION_HANDLER': 'luffyapi.utils.exceptions.custom_exception_handler',
    # 认证方式
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework_jwt.authentication.JSONWebTokenAuthentication',
        'rest_framework.authentication.SessionAuthentication',
        'rest_framework.authentication.BasicAuthentication',
    ),
    # 接口限流
    'DEFAULT_THROTTLE_RATES': {
        'sms': '100/day',
    }
}

import datetime
# jwt配置
JWT_AUTH = {
    # jwt的有效期
    'JWT_EXPIRATION_DELTA': datetime.timedelta(days=3),
    # jwt的自定义响应函数
    'JWT_RESPONSE_PAYLOAD_HANDLER': 'users.utils.jwt_response_payload_handler',
}

# 注册自定义用户模型,配置项的值格式必须: 子应用目录.模型类名
AUTH_USER_MODEL = 'users.User'
AUTHENTICATION_BACKENDS = ['users.utils.AuthModelBackend',]


# 腾讯防水墙配置
TENCENT_CAPTCHA = {
    # 验证码服务器地址[网关地址]
    "GATEWAY": "https://ssl.captcha.qq.com/ticket/verify",
    # 应用ID
    "APPID": "2059674751",
    # 应用秘钥
    "App_Secret_Key": "04LwtDUlnQxumWnItAw4OPA**",
}

# 云通讯短信配置
SMS = {
    "accId": "8a216da863f8e6c20164139687e80c1b",
    "accToken": "6dd01b2b60104b3dbc88b2b74158bac6",
    "appId": "8a216da863f8e6c20164139688400c21",
    "TempId": 1,
    "Geteway": "app.cloopen.com:8883",
}

# 富文本编辑器ckeditor配置
CKEDITOR_CONFIGS = {
    'default': {
        # 'toolbar': 'full',  # 工具条功能,full默认值,使用所有的工具栏显示给用户
        'toolbar': 'Basic',
        'toolbar_Basic': [
            ['Bold', 'Italic', 'Underline'],
            ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
            ['Link', 'Unlink'],
            ['RemoveFormat', 'Source'],
            ['Smiley','Table',"Image",'Blockquote']
        ],

        'height': 300,      # 编辑器高度
        # 'width': 300,     # 编辑器宽
    },
}
CKEDITOR_UPLOAD_PATH = ''  # 上传图片保存路径，留空则调用django的文件上传功能

# 支付宝配置信息
ALIAPY = {
    # "gateway_url": "https://openapi.alipay.com/gateway.do?", # 真实支付宝网关地址
    "gateway_url": "https://openapi.alipaydev.com/gateway.do?", # 沙箱支付宝网关地址
    "appid": "2016091600523592", # 应用ID
    "app_private_key_path": os.path.join(BASE_DIR, "apps/payments/keys/app_private_key.pem"),
    "alipay_public_key_path": os.path.join(BASE_DIR, "apps/payments/keys/alipay_public_key.pem"),
    "sign_type": "RSA2", # 秘钥加密类型
    "return_url": "http://3w.ipython.top/payments/alipay/result", # 同步回调地址
    "notify_url": "http://api.ipython.top/payments/alipay/result",  # 异步结果通知
}

# 保利威视频加密服务
POLYV = {
    "userId":"b94978510f", # 用户ID/appid
    "secretkey":"8RKY40w5w5", # 秘钥
    "tokenUrl":"https://hls.videocc.net/service/v1/token",
}

# 上线前收集静态文件
STATIC_ROOT = os.path.join(os.path.dirname(BASE_DIR), 'static')