import json
import os
import csv

from django.http import JsonResponse
from django.contrib.auth.models import User
from django.core.files.uploadedfile import SimpleUploadedFile

from .base import TestBase
from api.models import ChargeSession, Station, Car, Pricing, Point
from api.utils.common import get_now, datetime_to_string

class SystemViewTest(TestBase):
    def setUp(self):
        self.default_pass = "petrol4ever"
        self.admin = self._create_user("admin", "adminpass",
                "admin@here.com")
        self.admin.is_superuser = True
        self.admin.save()
        self.token = self._login_and_get_token(self.admin.username, "adminpass")

    def _create_dummy_sessions(self):
        ChargeSession.objects.create(
                car_id=None, point_id=None, pricing_id=None,
                energy_delivered=30, total_cost=300,
                start=get_now(), end=get_now(),
                payment='CD', protocol='WR')
        ChargeSession.objects.create(
                car_id=None, point_id=None, pricing_id=None,
                energy_delivered=10, total_cost=100,
                start=get_now(), end=get_now(),
                payment='CD', protocol='WR')
        ChargeSession.objects.create(
                car_id=None, point_id=None, pricing_id=None,
                energy_delivered=20, total_cost=200,
                start=get_now(), end=get_now(),
                payment='CD', protocol='WR')

    def test_healthcheck(self):
        resp = self.client.get(self._healthcheck_url())

        self.assertEqual(resp.status_code, 200)
        self.assertTrue(isinstance(resp, JsonResponse))
        body = json.loads(resp.content)
        self.assertTrue(body.get("status", False))
        self.assertEqual(body['status'], 'OK')

    def test_reset_sessions(self):
        # Create charge sessions items
        self._create_dummy_sessions()
        resp = self.client.delete(self._reset_url())

        self.assertEqual(resp.status_code, 200)
        self.assertTrue(isinstance(resp, JsonResponse))
        body = json.loads(resp.content)
        self.assertTrue(body.get("status", False))
        self.assertEqual(body['status'], "OK")

        # all charge sessions deleted
        self.assertEqual(len(ChargeSession.objects.all()), 0)

        # check that admin user has been created
        user = User.objects.get(username="admin")
        self.assertTrue(user.check_password(self.default_pass))

    def test_reset_sessions_admin_exists(self):
        self._create_dummy_sessions()

        old_pass = "old_pass"
        self.admin.password = "adminpass"
        self.admin.save()
        resp = self.client.delete(self._reset_url())

        user = User.objects.get(username="admin")

        self.assertFalse(user.check_password(old_pass))
        self.assertTrue(user.check_password(self.default_pass))

        # all charge sessions deleted
        self.assertEqual(len(ChargeSession.objects.all()), 0)

    def _create_dummy_file(self, rows):
        res = []
        for row in rows:
            r = ",".join([str(x).strip() for x in row])
            res.append(r.encode())

        fname = 'thisisadummyfile.donottouch'
        f = SimpleUploadedFile(fname, b'\n'.join(res), content_type='text/csv')
        return f

    def test_session_upload(self):
        # First: 3 dummy sessions in db
        self._create_dummy_sessions()

        # Then create the data that will be uploaded
        user = self._create_user("martin", "luther")
        station = Station.objects.create(
                latitude=1.0,
                longtitude=1.5,
                address="Baker Street",
                number="221B",
                zipcode="NW16XE",
                city="London",
                country="United Kingdom",
                operator=user
        )

        point = Point.objects.create(station_id=station)
        point.save()

        car = Car.objects.create(user_id=user,
                licence="something", type="lambo")
        car.save()

        pricing = Pricing.objects.create(station_id=station, description="hello", price=62)
        pricing.save()

        days = [str(self._current_time(self._get_prev_days(i))) for i in range(8)]

        # CSV Format: ENERGY_DELIVERED,TOTAL_COST,START,END,PAYMENT,PROTOCOL,CAR_ID,POINT_ID,PRICING_ID
        rows = [[62, 26, days[7], days[6], 'CD', 'WR', car.id, point.id, pricing.id],
                [26, 62, days[4], days[3], 'CD', 'WR', car.id, point.id, pricing.id]]

        f = self._create_dummy_file(rows)
        resp = self._sessionupd(f, self.token)
        self.assertEqual(resp.status_code, 200)
        self.assertTrue(isinstance(resp, JsonResponse))

        body = json.loads(resp.content)

        self.assertEqual(body['SessionsInUploadedFile'], 2)
        self.assertEqual(body['SessionsImported'], 2)
        self.assertEqual(body['TotalSessionsInDatabase'], 5)

        # Repeat request
        f = self._create_dummy_file(rows)
        resp = self._sessionupd(f, self.token)
        self.assertEqual(resp.status_code, 200)
        self.assertTrue(isinstance(resp, JsonResponse))
        body = json.loads(resp.content)

        self.assertEqual(body['SessionsInUploadedFile'], 2)
        self.assertEqual(body['SessionsImported'], 0)
        self.assertEqual(body['TotalSessionsInDatabase'], 5)
