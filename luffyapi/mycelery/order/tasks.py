from mycelery.main import app
from django.utils import timezone as datetime
from luffyapi.settings import constants
from orders.models import Order
@app.task(name="check_order")
def check_order():
    """订单超时取消"""
    now = datetime.now().timestamp()
    timeout_number = now - constants.ORDER_TIMEOUT
    timeout = datetime.datetime.fromtimestamp(timeout_number)
    timeout_order_list = Order.objects.filter(order_status=0, created_time__lte=timeout)
    for order in timeout_order_list:
        order.order_status = 3
        # todo 补充下优惠券和积分的逻辑
        # 1. 判断订单的积分是否大于0，大于0则还原积分
        # 2. 判断订单的优惠券是否大于0，大于0，则还原优惠券的使用状态
        order.save()
