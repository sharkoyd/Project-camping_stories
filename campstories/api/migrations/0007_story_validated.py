# Generated by Django 4.1.4 on 2023-07-05 22:23

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0006_userprofile_profileimg'),
    ]

    operations = [
        migrations.AddField(
            model_name='story',
            name='validated',
            field=models.BooleanField(default=False),
        ),
    ]
