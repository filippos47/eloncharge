from django.db import models

from .station import Station

class Pricing(models.Model):
    station_id = models.ForeignKey(Station, on_delete=models.CASCADE)
    description = models.CharField(max_length=1000)
    price = models.FloatField()
