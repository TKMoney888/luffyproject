import json,logging
from mycelery.main import app
from ronglian_sms_sdk import SmsSDK
from django.conf import settings
from luffyapi.settings import constants
from celery.app.task import Task
log = logging.getLogger("django")

# 异步任务的监听器
class SMSTask(Task):
    def on_success(self, retval, task_id, args, kwargs):
        print( '任务执行成功!')
        return super().on_success(retval, task_id, args, kwargs)

    def on_failure(self, exc, task_id, args, kwargs, einfo):
        print('任务执行失败!')
        return super().on_failure(exc, task_id, args, kwargs, einfo)

    def after_return(self, status, retval, task_id, args, kwargs, einfo):
        print('this is after return')
        return super().after_return(status, retval, task_id, args, kwargs, einfo)

    def on_retry(self, exc, task_id, args, kwargs, einfo):
        print('this is retry')
        return super().on_retry(exc, task_id, args, kwargs, einfo)

@app.task(name="send_sms",base=SMSTask)
def send_sms(mobile,code):
    """发送短信"""
    sdk = SmsSDK(
        settings.SMS.get("accId"),
        settings.SMS.get("accToken"),
        settings.SMS.get("appId"),
    )

    try:
        resp = sdk.sendMessage(settings.SMS.get("TempId"), mobile, (code, constants.SMS_EXPIRE_TIME // 60))
        resp_data = json.loads(resp)
        if resp_data.get("statusCode") != "000000":
            raise Exception
    except Exception as exc:
        log.error("短信发送失败! 手机号:%s: %s" % (mobile, exc))
        raise Exception