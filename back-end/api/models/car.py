from django.db import models
from django.contrib.auth.models import User

class Car(models.Model):
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)
    licence = models.CharField(max_length=10, unique=True)
    brand = models.CharField(max_length=255, null=True)
    model = models.CharField(max_length=255, null=True)
    release = models.DateField(null=True)
    consumption = models.PositiveIntegerField(null=True)
    type = models.CharField(max_length=255)
