from django.test import TestCase
from django.contrib.auth.models import User

from api.models import Station

class StationTest(TestCase):
    def setUp(self):
        self.operator = User.objects.create(username="Sherlock",
                password="Holmes", email="sherlock@detective.com")

    def test_creation(self):
        # check that a station object can be properly created
        station = Station.objects.create(
                latitude=1.0,
                longtitude=1.5,
                address="Baker Street",
                number="221B",
                zipcode="NW16XE",
                city="London",
                country="United Kingdom",
                operator=self.operator
        )
        station.save()

        # check that on operator deletion, the station.operator becomes null
        self.operator.delete()

        station = Station.objects.get(address="Baker Street")
        self.assertEqual(station.operator, None)
