# Generated by Django 4.2.3 on 2023-07-07 10:46

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='StoryPictureRand',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('genre', models.CharField(choices=[('action', 'Action'), ('adventure', 'Adventure'), ('comedy', 'Comedy'), ('fantasy', 'Fantasy'), ('mystery', 'Mystery'), ('science_fiction', 'Science Fiction'), ('fairy_tale', 'Fairy Tale'), ('animal', 'Animal'), ('educational', 'Educational'), ('historical', 'Historical')], max_length=20)),
                ('picture', models.ImageField(blank=True, null=True, upload_to='story_pictures')),
            ],
        ),
        migrations.CreateModel(
            name='UserProfile',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=255)),
                ('gender', models.CharField(choices=[('M', 'Male'), ('F', 'Female')], max_length=1)),
                ('profileimg', models.CharField(choices=[('img1', 'Image 1'), ('img2', 'Image 2'), ('img3', 'Image 3'), ('img4', 'Image 4')], default='img0', max_length=10)),
                ('age', models.PositiveIntegerField()),
                ('scores', models.TextField(default='{"action": 0, "adventure": 0, "comedy": 0, "fantasy": 0, "mystery": 0, "science_fiction": 0, "fairy_tale": 0, "animal": 0, "educational": 0, "historical": 0}')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='profiles', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Story',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=100)),
                ('content', models.TextField()),
                ('age_range', models.IntegerField()),
                ('gender', models.CharField(choices=[('M', 'Male'), ('F', 'Female'), ('A', 'Any')], max_length=1)),
                ('story_type', models.CharField(choices=[('action', 'Action'), ('adventure', 'Adventure'), ('comedy', 'Comedy'), ('fantasy', 'Fantasy'), ('mystery', 'Mystery'), ('science_fiction', 'Science Fiction'), ('fairy_tale', 'Fairy Tale'), ('animal', 'Animal'), ('educational', 'Educational'), ('historical', 'Historical')], max_length=20)),
                ('length_minutes', models.PositiveIntegerField(choices=[(1, '1 minute'), (2, '2 minutes'), (5, '5 minutes'), (10, '10 minutes')], default=1)),
                ('validated', models.BooleanField(default=False)),
                ('audio_file', models.FileField(blank=True, default=None, null=True, upload_to='audio_files')),
                ('picture', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, to='api.storypicturerand')),
            ],
        ),
        migrations.CreateModel(
            name='PendingCode',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('code', models.CharField(max_length=6)),
                ('created_at', models.DateTimeField(default=django.utils.timezone.now)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='Code',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('code', models.CharField(max_length=6)),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
