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

class StationViewTest(TestBase):
    def setUp(self):
        self.user = self._create_user("martin", "luther")

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
        self.point1 = Point.objects.create(station_id=self.station)
        self.point1.save()
        self.point2 = Point.objects.create(station_id=self.station)
        self.point2.save()

        self.days = [self._get_prev_days(i) for i in range(8)]

        self.charge1 = ChargeSession.objects.create(
                car_id=None, point_id=self.point1, pricing_id=None,
                energy_delivered=10, total_cost=100,
                start=self.days[3], end=self.days[2],
                payment='CD', protocol='WR')
        self.charge1.save()
        self.charge2 = ChargeSession.objects.create(
                car_id=None, point_id=self.point1, pricing_id=None,
                energy_delivered=20, total_cost=200,
                start=self.days[3], end=self.days[2],
                payment='CD', protocol='WR')
        self.charge2.save()
        self.charge3 = ChargeSession.objects.create(
                car_id=None, point_id=self.point2, pricing_id=None,
                energy_delivered=30, total_cost=300,
                start=self.days[1], end=self.days[0],
                payment='CD', protocol='WR')
        self.charge3.save()

        self.token = self._login_and_get_token(self.user.username, "luther")

    def _elapsed(self, dt):
        return datetime.datetime.timestamp(get_now()) - datetime.datetime.timestamp(datetime_from_string(dt))

    def test_get_station_charges(self):
        resp = self._retrieve_sessions(self._station_url, self.token,
                self.station.id, self.days[4], self.days[0], csv=False)

        self.assertEqual(resp.status_code, 200)
        self.assertTrue(isinstance(resp, JsonResponse))
        body = json.loads(resp.content)

        self.assertTrue(body.get('StationID', False))
        self.assertEqual(body['StationID'], self.station.id)

        self.assertTrue(body.get('Operator', False))
        self.assertEqual(body['Operator'], self.station.operator.username)

        self.assertTrue(body.get('RequestTimestamp', False))
        self.assertTrue(self._elapsed(body['RequestTimestamp']) < 10000)

        self.assertTrue(body.get('PeriodFrom', False))
        self.assertEqual(body['PeriodFrom'], datetime_to_string(self._current_time(self.days[4])))

        self.assertTrue(body.get('PeriodTo', False))
        self.assertEqual(body['PeriodTo'], datetime_to_string(self._current_time(self.days[0])))

        self.assertTrue(body.get('TotalEnergyDelivered', False))
        self.assertEqual(body['TotalEnergyDelivered'], 60)

        self.assertTrue(body.get('NumberOfChargingSessions', False))
        self.assertEqual(body['NumberOfChargingSessions'], 3)

        self.assertTrue(body.get('NumberOfActivePoints', False))
        self.assertEqual(body['NumberOfActivePoints'], 2)

        self.assertTrue(body.get('SessionsSummaryList', False))
        self.assertEqual(len(body['SessionsSummaryList']), body['NumberOfActivePoints'])

        # test first result
        first = body['SessionsSummaryList'][0]
        self.assertTrue(first.get('PointID', False))
        self.assertEqual(int(first['PointID']), self.point1.id)

        self.assertTrue(first.get('PointSessions', False))
        self.assertEqual(first['PointSessions'], 2)

        self.assertTrue(first.get('EnergyDelivered', False))
        self.assertEqual(first['EnergyDelivered'], 30)

        # test second result
        second = body['SessionsSummaryList'][1]
        self.assertTrue(second.get('PointID', False))
        self.assertEqual(int(second['PointID']), self.point2.id)

        self.assertTrue(second.get('PointSessions', False))
        self.assertEqual(second['PointSessions'], 1)

        self.assertTrue(second.get('EnergyDelivered', False))
        self.assertEqual(second['EnergyDelivered'], 30)

    def test_get_station_charges_csv(self):
        resp = self._retrieve_sessions(self._station_url, self.token,
                self.station.id, self.days[4], self.days[0], csv=True)

        self.assertEqual(resp.status_code, 200)
        reader = csv.reader(resp.content.decode('utf-8').splitlines(), delimiter=",")

        items = list(reader)

        self.assertEqual(len(items), 3)
        for idx, item in enumerate(reader):
            if idx == 0:
                self.assertEqual(item,
                        ["StationID", "Operator", "RequestTimestamp",
                        "PeriodFrom", "PeriodTo", "TotalEnergyDelivered",
                        "NumberOfChargingSessions", "NumberOfActivePoints",
                        "PointID", "PointSessions", "EnergyDelivered"])
            else:
                self.assertEqual(item[0], self.station.id)
                self.assertEqual(item[1], self.operator.username)
                if idx == 1:
                    self.assertEqual(item[8], self.point1.id)
                    self.assertEqual(item[9], 2)
                    self.assertEqual(item[10], 30)
                elif idx == 2:
                    self.assertEqual(item[8], self.point2.id)
                    self.assertEqual(item[9], 1)
                    self.assertEqual(item[10], 30)

    def test_get_unauthorized(self):
        user2 = self._create_user("someone", "else")
        token2 = self._login_and_get_token(user2.username, "else")

        resp = self._retrieve_sessions(self._station_url, token2,
                self.station.id, self.days[4], self.days[0], csv=False)

        # should be unauthorized
        self.assertEqual(resp.status_code, 401)
        self.assertTrue(isinstance(resp, HttpResponse))

    def test_invalid_dates(self):
        resp = self._retrieve_sessions(self._station_url, self.token,
                self.station.id, self.days[5], self.days[4], csv=False)

        self.assertEqual(resp.status_code, 200)
        self.assertTrue(isinstance(resp, JsonResponse))
        body = json.loads(resp.content)

        self.assertTrue(body.get('StationID', False))
        self.assertEqual(body['StationID'], self.station.id)

        self.assertTrue(body.get('Operator', False))
        self.assertEqual(body['Operator'], self.station.operator.username)

        self.assertTrue(body.get('RequestTimestamp', False))
        self.assertTrue(self._elapsed(body['RequestTimestamp']) < 10000)

        self.assertTrue(body.get('PeriodFrom', False))
        self.assertEqual(body['PeriodFrom'], datetime_to_string(self._current_time(self.days[5])))

        self.assertTrue(body.get('PeriodTo', False))
        self.assertEqual(body['PeriodTo'], datetime_to_string(self._current_time(self.days[4])))

        self.assertTrue(body.get('NumberOfChargingSessions', False) == 0)

        self.assertTrue(body.get('NumberOfActivePoints', False) == 0)

        self.assertTrue(body.get('SessionsSummaryList', False) == [])

    def test_invalid_date_format(self):
        resp = self.client.get(self._station_url(self.station.id,
            datetime_to_string(self.days[7]), "invalid_format"),
            HTTP_X_AUTH_OBSERVATORY=self.token)
        self.assertEqual(resp.status_code, 400)

        resp = self.client.get(self._station_url(self.station.id,
            "invalid_format", datetime_to_string(self.days[0])),
            HTTP_X_AUTH_OBSERVATORY=self.token)
        self.assertEqual(resp.status_code, 400)

    def test_invalid_station_id(self):
        resp = self._retrieve_sessions(self._station_url, self.token,
                "idonotexisthahah", self.days[7], self.days[0], csv=False)

        self.assertEqual(resp.status_code, 400)
        self.assertTrue(isinstance(resp, HttpResponseBadRequest))
