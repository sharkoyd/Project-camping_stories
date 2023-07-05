from .models import Code
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver

@receiver(post_save, sender=User)
def post_save_create_code(sender, instance, created, **kwargs):
    if created:
        Code.objects.create(user=instance)
