# Generated by Django 2.2 on 2020-10-13 03:59

import datetime
from django.db import migrations, models
from django.utils.timezone import utc


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0007_auto_20201012_0303'),
    ]

    operations = [
        migrations.AlterField(
            model_name='activity',
            name='end_time',
            field=models.DateTimeField(default=datetime.datetime(2020, 10, 13, 3, 59, 5, 255335, tzinfo=utc), verbose_name='结束时间'),
        ),
        migrations.AlterField(
            model_name='activity',
            name='start_time',
            field=models.DateTimeField(default=datetime.datetime(2020, 10, 13, 3, 59, 5, 255284, tzinfo=utc), verbose_name='开始时间'),
        ),
    ]
