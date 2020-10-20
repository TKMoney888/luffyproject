import os,django
from celery import Celery
# 初始化celery对象
app = Celery("luffy")

# 初始化django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'luffyapi.settings.dev')
django.setup()

# 加载配置
app.config_from_object("mycelery.config")
# 自动注册任务
app.autodiscover_tasks(["mycelery.sms","mycelery.email","mycelery.order"])
# 运行celery
# 终端下: celery -A mycelery.main worker -l info