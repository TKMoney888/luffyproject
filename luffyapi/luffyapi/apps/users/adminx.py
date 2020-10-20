import xadmin
from .models import Credit
class CreditModelAdmin(object):
    """用户积分收支记录"""
    list_display=["user","created_time","operation","number"]

    def save_models(self):
        """
        当站点保存当前模型时
        """
        if not self.new_obj.id:
            """添加积分操作"""
            number = int(self.new_obj.number)
            self.new_obj.user.credit += number
            self.new_obj.user.save()
        self.new_obj.save()

xadmin.site.register(Credit, CreditModelAdmin)