from django.test import TestCase
from django.contrib.auth.models import User

from api.models import Station, Point

class PointTest(TestCase):
    def setUp(self):
        self.user = User.objects.create(username="Sherlock",
                password="Holmes", email="sherlock@detective.com")
        self.station = Station.objects.create(
                latitude=1.0,
                longtitude=1.5,
                address="Baker Street",
                number="221B",
                zipcode="NW16XE",
                city="London",
                country="United Kingdom",
                operator=self.user
        )

    def test_creation(self):
        # not much to test here
        point = Point.objects.create(station_id=self.station)
        point.save()
