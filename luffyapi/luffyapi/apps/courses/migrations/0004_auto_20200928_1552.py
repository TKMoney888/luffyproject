# Generated by Django 2.2 on 2020-09-28 07:52

import datetime
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('courses', '0003_auto_20200928_0957'),
    ]

    operations = [
        migrations.CreateModel(
            name='Activity',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(blank=True, default=None, max_length=150, null=True, verbose_name='名称/标题')),
                ('orders', models.IntegerField(default=0, verbose_name='显示顺序')),
                ('is_show', models.BooleanField(default=True, verbose_name='是否上架')),
                ('is_delete', models.BooleanField(default=False, verbose_name='逻辑删除')),
                ('created_time', models.DateTimeField(auto_now_add=True, verbose_name='创建时间')),
                ('updateed_time', models.DateTimeField(auto_now=True, verbose_name='更新时间')),
                ('start_time', models.DateTimeField(default=datetime.datetime(2020, 9, 28, 15, 52, 26, 283781), verbose_name='开始时间')),
                ('end_time', models.DateTimeField(default=datetime.datetime(2020, 9, 28, 15, 52, 26, 283808), verbose_name='结束时间')),
            ],
            options={
                'verbose_name': '活动记录表',
                'verbose_name_plural': '活动记录表',
                'db_table': 'ly_activity',
            },
        ),
        migrations.CreateModel(
            name='CourseDiscountType',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(blank=True, default=None, max_length=150, null=True, verbose_name='名称/标题')),
                ('orders', models.IntegerField(default=0, verbose_name='显示顺序')),
                ('is_show', models.BooleanField(default=True, verbose_name='是否上架')),
                ('is_delete', models.BooleanField(default=False, verbose_name='逻辑删除')),
                ('created_time', models.DateTimeField(auto_now_add=True, verbose_name='创建时间')),
                ('updateed_time', models.DateTimeField(auto_now=True, verbose_name='更新时间')),
                ('remark', models.CharField(blank=True, max_length=250, null=True, verbose_name='备注信息')),
            ],
            options={
                'verbose_name': '课程优惠类型',
                'verbose_name_plural': '课程优惠类型',
                'db_table': 'ly_course_discount_type',
            },
        ),
        migrations.AlterField(
            model_name='course',
            name='price',
            field=models.DecimalField(decimal_places=2, default=0, help_text="此处填写价格属于永久购买价格,如果没有<b style='color: red;'>永久购买</b>期限,则默认价格为0,请不要随意删除", max_digits=6, verbose_name='课程原价'),
        ),
        migrations.CreateModel(
            name='CourseDiscount',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(blank=True, default=None, max_length=150, null=True, verbose_name='名称/标题')),
                ('orders', models.IntegerField(default=0, verbose_name='显示顺序')),
                ('is_show', models.BooleanField(default=True, verbose_name='是否上架')),
                ('is_delete', models.BooleanField(default=False, verbose_name='逻辑删除')),
                ('created_time', models.DateTimeField(auto_now_add=True, verbose_name='创建时间')),
                ('updateed_time', models.DateTimeField(auto_now=True, verbose_name='更新时间')),
                ('condition', models.IntegerField(blank=True, default=0, help_text='设置享受优惠的价格条件,如果没有条件则默认为0即可', verbose_name='满足优惠的价格条件')),
                ('sale', models.TextField(help_text='\n    0表示免费；<br>\n    *号开头表示折扣价，例如填写*0.82,则表示八二折；<br>\n    -号开头表示减免价, 例如填写-100,则表示减免100；<br>\n    表示满减,则需要使用 原价-优惠价格,例如表示,课程价格大于100,优惠10;大于200,优惠20,格式如下:<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;满100-10<br>\n    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;满200-20<br>\n    ', verbose_name='优惠公式')),
                ('discount_type', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='discounts', to='courses.CourseDiscountType', verbose_name='优惠类型')),
            ],
            options={
                'verbose_name': '课程优惠策略',
                'verbose_name_plural': '课程优惠策略',
                'db_table': 'ly_course_discount',
            },
        ),
        migrations.CreateModel(
            name='ActivityDiscount',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(blank=True, default=None, max_length=150, null=True, verbose_name='名称/标题')),
                ('orders', models.IntegerField(default=0, verbose_name='显示顺序')),
                ('is_show', models.BooleanField(default=True, verbose_name='是否上架')),
                ('is_delete', models.BooleanField(default=False, verbose_name='逻辑删除')),
                ('created_time', models.DateTimeField(auto_now_add=True, verbose_name='创建时间')),
                ('updateed_time', models.DateTimeField(auto_now=True, verbose_name='更新时间')),
                ('activity', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='activity_course', to='courses.Activity', verbose_name='活动')),
                ('course', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='course_activity', to='courses.Course', verbose_name='课程')),
                ('discount', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='discount_activity', to='courses.CourseDiscount', verbose_name='优惠')),
            ],
            options={
                'verbose_name': '课程活动价格表',
                'verbose_name_plural': '课程活动价格表',
                'db_table': 'ly_activity_discount',
            },
        ),
    ]
