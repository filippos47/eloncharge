from django.db import models
from django.contrib.auth.models import User

class Station(models.Model):
    latitude = models.FloatField()
    longtitude = models.FloatField()
    address = models.CharField(max_length=255)
    number = models.PositiveIntegerField()
    zipcode = models.PositiveIntegerField()
    city = models.CharField(max_length=255)
    region = models.CharField(max_length=255)
    country = models.CharField(max_length=255)
    operator = models.ForeignKey(User, null=True,
            on_delete=models.SET_NULL)
