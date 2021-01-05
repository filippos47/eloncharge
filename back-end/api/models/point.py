from django.db import models
from .station import Station

class Point(models.Model):
    station_id = models.ForeignKey(Station, on_delete=models.CASCADE)
