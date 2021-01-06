from django.test import TestCase
from django.contrib.auth.models import User

from api.models import Station, Pricing

class PricingTest(TestCase):
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
        # created correctly
        pricing = Pricing.objects.create(station_id=self.station,
                description="capitalism", price=1000)
        pricing.save()

        # price must be a number
        with self.assertRaises(ValueError):
            pricing = Pricing.objects.create(station_id=self.station,
                    description="capitalism", price="haha")
