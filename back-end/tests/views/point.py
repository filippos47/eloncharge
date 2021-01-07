import json
import csv
import datetime

from django.test import TestCase
from django.http import JsonResponse, HttpResponse,\
        HttpResponseBadRequest

from .base import TestBase
from api.utils.common import get_now, datetime_to_string,\
    datetime_from_string
from api.models import Car, ChargeSession, Station, Point, Pricing
from django.utils import timezone

class PointViewTest(TestBase):
    def setUp(self):
        self.user = self._create_user("martin", "luther")

        station = Station.objects.create(
                latitude=1.0,
                longtitude=1.5,
                address="Baker Street",
                number="221B",
                zipcode="NW16XE",
                city="London",
                country="United Kingdom",
                operator=self.user
        )
        self.point = Point.objects.create(station_id=station)
        self.point.save()

        car1 = Car.objects.create(user_id=self.user,
                licence="something", type="lambo")
        car1.save()
        car2 = Car.objects.create(user_id=self.user,
                licence="else", type="corolla")
        car2.save()

        self.days = [self._get_prev_days(i) for i in range(8)]

        self.charge1 = ChargeSession.objects.create(
                car_id=car1, point_id=self.point, pricing_id=None,
                energy_delivered=10, total_cost=100,
                start=self.days[7], end=self.days[6],
                payment='CD', protocol='WR')
        self.charge1.save()
        self.charge2 = ChargeSession.objects.create(
                car_id=car1, point_id=self.point, pricing_id=None,
                energy_delivered=20, total_cost=200,
                start=self.days[3], end=self.days[2],
                payment='CD', protocol='WR')
        self.charge2.save()
        self.charge3 = ChargeSession.objects.create(
                car_id=car2, point_id=self.point, pricing_id=None,
                energy_delivered=30, total_cost=300,
                start=self.days[1], end=self.days[0],
                payment='CD', protocol='WR')
        self.charge3.save()

        self.token = self._login_and_get_token(self.user.username, "luther")

    def _elapsed(self, dt):
        return datetime.datetime.timestamp(get_now()) - datetime.datetime.timestamp(datetime_from_string(dt))

    def _verify_point_res(self, actual, expected):
        self.assertTrue(actual.get('SessionID', False))
        self.assertEqual(int(actual['SessionID']), expected.id)

        self.assertTrue(actual.get('StartedOn', False))
        self.assertEqual(actual['StartedOn'], datetime_to_string(expected.start))

        self.assertTrue(actual.get('FinishedOn', False))
        self.assertEqual(actual['FinishedOn'], datetime_to_string(expected.end))

        self.assertTrue(actual.get('Protocol', False))
        self.assertEqual(actual['Protocol'], expected.protocol)

        self.assertTrue(actual.get('EnergyDelivered', False))
        self.assertEqual(actual['EnergyDelivered'], expected.energy_delivered)

        self.assertTrue(actual.get('Payment', False))
        self.assertEqual(actual['Payment'], expected.payment)

        self.assertTrue(actual.get('VehicleType', False))
        self.assertEqual(actual['VehicleType'], expected.car_id.type)

    def test_get_point_charges(self):
        resp = self._retrieve_sessions(self._point_url, self.token,
                self.point.id, self.days[4], self.days[0], csv=False)

        self.assertEqual(resp.status_code, 200)
        self.assertTrue(isinstance(resp, JsonResponse))
        body = json.loads(resp.content)

        self.assertTrue(body.get('Point', False))
        self.assertEqual(body['Point'], self.point.id)

        self.assertTrue(body.get('PointOperator', False))
        self.assertEqual(body['PointOperator'], self.point.station_id.operator.username)

        self.assertTrue(body.get('RequestTimestamp', False))
        self.assertTrue(self._elapsed(body['RequestTimestamp']) < 10000)

        self.assertTrue(body.get('PeriodFrom', False))
        self.assertEqual(body['PeriodFrom'], datetime_to_string(self._current_time(self.days[4])))

        self.assertTrue(body.get('PeriodTo', False))
        self.assertEqual(body['PeriodTo'], datetime_to_string(self._current_time(self.days[0])))

        self.assertTrue(body.get('NumberOfChargingSessions', False))
        self.assertEqual(body['NumberOfChargingSessions'], 2)

        self.assertTrue(body.get('ChargingSessionsList', False))
        self.assertEqual(len(body['ChargingSessionsList']), int(body['NumberOfChargingSessions']))

        # test first result
        first = body['ChargingSessionsList'][0]
        self.assertTrue(first.get('SessionIndex', False))
        self.assertEqual(int(first['SessionIndex']), 1)

        self._verify_point_res(first, self.charge2)

        # test second result
        second = body['ChargingSessionsList'][1]
        self.assertTrue(second.get('SessionIndex', False))
        self.assertEqual(int(second['SessionIndex']), 2)

        self._verify_point_res(second, self.charge3)

    def test_get_point_charges_csv(self):
        resp = self._retrieve_sessions(self._point_url, self.token,
                self.point.id, self.days[4], self.days[0], csv=True)

        self.assertEqual(resp.status_code, 200)
        reader = csv.reader(resp.content.decode('utf-8').splitlines(), delimiter=",")

        items = list(reader)

        self.assertEqual(len(items), 3)
        for idx, item in enumerate(reader):
            if idx == 0:
                self.assertEqual(item,
                        ["Point", "PointOperator", "RequestTimestamp",
                        "PeriodFrom", "PeriodTo", "NumberOfChargingSessions",
                        "ChargingSessionsList", "SessionIndex",
                        "SessionID", "StartedOn", "FinishedOn",
                        "Protocol", "EnergyDelivered", "Payment",
                        "VehicleType"])
            else:
                self.assertEqual(item[0], self.point.id)
                self.assertEqual(item[1], self.point.station_id.operator.username)
                if idx == 1:
                    self.assertEqual(item[8], self.charge2.id)
                    self.assertEqual(item[12], self.charge2.energy_delivered)
                elif idx == 2:
                    self.assertEqual(item[8], self.charge3.id)
                    self.assertEqual(item[12], self.charge3.energy_delivered)

    def test_get_unauthorized(self):
        user2 = self._create_user("someone", "else")
        token2 = self._login_and_get_token(user2.username, "else")

        resp = self._retrieve_sessions(self._point_url, token2,
                self.point.id, self.days[4], self.days[0], csv=False)

        # should be unauthorized
        self.assertEqual(resp.status_code, 401)
        self.assertTrue(isinstance(resp, HttpResponse))

    def test_invalid_dates(self):
        resp = self._retrieve_sessions(self._point_url, self.token,
                self.point.id, self.days[5], self.days[4], csv=False)

        self.assertEqual(resp.status_code, 200)
        self.assertTrue(isinstance(resp, JsonResponse))
        body = json.loads(resp.content)

        self.assertTrue(body.get('Point', False))
        self.assertEqual(body['Point'], self.point.id)

        self.assertTrue(body.get('PointOperator', False))
        self.assertEqual(body['PointOperator'], self.point.station_id.operator.username)

        self.assertTrue(body.get('RequestTimestamp', False))
        self.assertTrue(self._elapsed(body['RequestTimestamp']) < 10000)

        self.assertTrue(body.get('PeriodFrom', False))
        self.assertEqual(body['PeriodFrom'], datetime_to_string(self._current_time(self.days[5])))

        self.assertTrue(body.get('PeriodTo', False))
        self.assertEqual(body['PeriodTo'], datetime_to_string(self._current_time(self.days[4])))

        self.assertTrue(body.get('NumberOfChargingSessions', False) == 0)

        self.assertTrue(body.get('ChargingSessionsList', False) == [])

    def test_invalid_date_format(self):
        resp = self.client.get(self._point_url(self.point.id,
            datetime_to_string(self.days[7]), "invalid_format"),
            HTTP_X_AUTH_OBSERVATORY=self.token)
        self.assertEqual(resp.status_code, 400)

        resp = self.client.get(self._point_url(self.point.id,
            "invalid_format", datetime_to_string(self.days[0])),
            HTTP_X_AUTH_OBSERVATORY=self.token)
        self.assertEqual(resp.status_code, 400)

    def test_invalid_point_id(self):
        resp = self._retrieve_sessions(self._point_url, self.token,
                "idonotexisthahah", self.days[7], self.days[0], csv=False)

        self.assertEqual(resp.status_code, 400)
        self.assertTrue(isinstance(resp, HttpResponseBadRequest))
