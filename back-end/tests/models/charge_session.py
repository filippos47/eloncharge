from django.test import TestCase
from django.contrib.auth.models import User

from api.models import Car, Point, Pricing, Station, ChargeSession
from api.utils.common import token_expires_delta
from django.utils.timezone import now

class ChargeSessionTest(TestCase):
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
        self.car = Car.objects.create(user_id=self.user, licence="221B")
        self.point = Point.objects.create(station_id=self.station)
        self.pricing = Pricing.objects.create(station_id=self.station,
                description="capitalism", price=1000)

        self.payment_choices = ['CD', 'CH']
        self.protocol_choices = ['WR', 'WD']

        self.ch_sess = ChargeSession.objects.create(
                car_id=self.car,
                point_id=self.point,
                pricing_id=self.pricing,
                energy_delivered=42,
                total_cost=17,
                start=token_expires_delta(past=True),
                end=now(),
                payment=self.payment_choices[0],
                protocol=self.protocol_choices[0])

    def test_creation(self):
        # simple creation of object
        self.ch_sess.save()


    def test_attr_deletion(self):
        # check that when the car is deleted, field is set to null
        self.car.delete()
        ch_sess = ChargeSession.objects.get(id=self.ch_sess.id)
        self.assertEqual(ch_sess.car_id, None)

        # check that when the pricing is deleted, field is set to null
        self.pricing.delete()
        ch_sess = ChargeSession.objects.get(id=self.ch_sess.id)
        self.assertEqual(ch_sess.pricing_id, None)

        # check that when the point is deleted, field is set to null
        self.point.delete()
        ch_sess = ChargeSession.objects.get(id=self.ch_sess.id)
        self.assertEqual(ch_sess.point_id, None)
