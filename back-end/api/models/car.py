from django.db import models
from django.contrib.auth.models import User

class Car(models.Model):
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)
    licence = models.CharField(max_length=10, unique=True)
    brand = models.CharField(max_length=255, null=True, default=None)
    model = models.CharField(max_length=255, null=True, default=None)
    release = models.DateField(null=True, default=None)
    consumption = models.PositiveIntegerField(null=True, default=None)
    type = models.CharField(max_length=255)
