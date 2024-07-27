# Generated by Django 5.0.6 on 2024-06-25 04:21

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0015_product_manufacturer'),
    ]

    operations = [
        migrations.CreateModel(
            name='PCDetail',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('processor', models.CharField(max_length=100)),
                ('ram', models.CharField(max_length=50)),
                ('storage', models.CharField(max_length=100)),
                ('graphics_card', models.CharField(max_length=100)),
                ('operating_system', models.CharField(max_length=50)),
                ('warranty', models.IntegerField(help_text='Warranty period in months')),
                ('product', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='pc_detail', to='app.product')),
            ],
        ),
    ]
