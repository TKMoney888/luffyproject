# Generated by Django 2.2 on 2020-10-14 04:34

import datetime
from django.db import migrations, models
from django.utils.timezone import utc


class Migration(migrations.Migration):

    dependencies = [
        ('coupon', '0002_auto_20201013_1159'),
    ]

    operations = [
        migrations.AlterField(
            model_name='usercoupon',
            name='start_time',
            field=models.DateTimeField(default=datetime.datetime(2020, 10, 14, 4, 34, 0, 452244, tzinfo=utc), verbose_name='优惠券的启用时间'),
        ),
    ]
