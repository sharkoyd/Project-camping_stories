from django.contrib import admin
from .models import  Code, PendingCode, UserProfile,Story
# Register your models here.
admin.site.register(Code)
admin.site.register(PendingCode)
admin.site.register(UserProfile)
admin.site.register(Story)