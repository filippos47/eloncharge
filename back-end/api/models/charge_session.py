from django.db import models
from django.utils.translation import gettext_lazy as _

from .car import Car
from .point import Point
from .pricing import Pricing

class ChargeSession(models.Model):
    class Payment(models.TextChoices):
        CARD = 'CD', _('Card')
        CASH = 'CH', _('Cash')

    class Protocol(models.TextChoices):
        WIRELESS = 'WR', _('Wireless')
        WIRED = 'WD', _('Wired')

    car_id = models.ForeignKey(Car, null=True,
            on_delete=models.SET_NULL)
    point_id = models.ForeignKey(Point, null=True,
            on_delete=models.SET_NULL)
    pricing_id = models.ForeignKey(Pricing, null=True,
            on_delete=models.SET_NULL)
    energy_delivered = models.FloatField()
    total_cost = models.FloatField()
    start = models.DateTimeField()
    end = models.DateTimeField()
    payment = models.CharField(
            max_length=2,
            choices=Payment.choices)
    protocol = models.CharField(
            max_length=2,
            choices=Protocol.choices)
