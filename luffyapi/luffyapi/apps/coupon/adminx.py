import xadmin
from crispy_forms.layout import Fieldset
from .models import Coupon

class CouponModelAdmin(object):
    """优惠券模型管理类"""
    list_display = ["name","coupon_type","duration","number","method"]
xadmin.site.register(Coupon, CouponModelAdmin)


from .models import UserCoupon
class UserCouponModelAdmin(object):
    """我的优惠券模型管理类"""
    list_display = ["user","coupon","start_time","is_use"]
    form_layout = (
        Fieldset("必填项", 'user','coupon','start_time'),
        Fieldset(None, 'name','is_show','is_delete','orders',**{"style":"display:none;"} ),
    )

xadmin.site.register(UserCoupon, UserCouponModelAdmin)