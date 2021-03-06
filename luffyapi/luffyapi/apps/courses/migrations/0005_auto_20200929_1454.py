# Generated by Django 2.2 on 2020-09-29 06:54

import datetime
from django.db import migrations, models
from django.utils.timezone import utc


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0004_auto_20200928_1552'),
    ]

    operations = [
        migrations.AlterField(
            model_name='activity',
            name='end_time',
            field=models.DateTimeField(default=datetime.datetime(2020, 9, 29, 6, 54, 10, 794324, tzinfo=utc), verbose_name='结束时间'),
        ),
        migrations.AlterField(
            model_name='activity',
            name='start_time',
            field=models.DateTimeField(default=datetime.datetime(2020, 9, 29, 6, 54, 10, 794301, tzinfo=utc), verbose_name='开始时间'),
        ),
    ]
