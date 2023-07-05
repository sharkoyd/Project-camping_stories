from django.db import models
from django.contrib.auth.models import User
import random 
from django.utils import timezone
import json


# Create your models here.

class Code(models.Model):
    code = models.CharField(max_length=6)
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    def __str__(self):
        return self.code
    def save(self, *args, **kwargs):
        number_list=[x for x in range(10)]
        code_items=[]
        for i in range(6):
            num = random.choice(number_list)
            code_items.append(num)
        code_string = "".join(str(item) for item in code_items)
        self.code = code_string
        super(Code, self).save(*args, **kwargs)



class PendingCode(models.Model):
    code = models.CharField(max_length=6)
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(default=timezone.now)

    def __str__(self):
        return self.code
    


class UserProfile(models.Model):
    GENDER_CHOICES = [
        ('M', 'Male'),
        ('F', 'Female'),
        ('O', 'Other'),
    ]

    STORY_TYPES = [
        ('action', 'Action'),
        ('adventure', 'Adventure'),
        ('comedy', 'Comedy'),
        # Add more story types as needed
    ]

    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='profiles')
    name = models.CharField(max_length=255)
    gender = models.CharField(max_length=1, choices=GENDER_CHOICES)
    age = models.PositiveIntegerField()
    scores = models.TextField(default=json.dumps({
        story_type: 0 for story_type, _ in STORY_TYPES
    }))  # Field to store story scores

    def get_scores(self):
        return json.loads(self.scores)

    def set_scores(self, scores):
        self.scores = json.dumps(scores)

    def __str__(self):
        return (self.name)