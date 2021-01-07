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

class EVViewTest(TestBase):
    def setUp(self):
        self.user = self._create_user("martin", "luther")
        self.car = Car.objects.create(user_id=self.user, licence="something")
        self.car.save()

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
        point1 = Point.objects.create(station_id=station)
        point1.save()
        point2 = Point.objects.create(station_id=station)
        point2.save()

        pricing1 = Pricing.objects.create(station_id=station,
                description="capitalism", price=1000)
        pricing1.save()

        pricing2 = Pricing.objects.create(station_id=station,
                description="communism", price=420)
        pricing2.save()

        self.days = [self._get_prev_days(i) for i in range(8)]

        self.charge1 = ChargeSession.objects.create(
                car_id=self.car, point_id=point1, pricing_id=pricing1,
                energy_delivered=10, total_cost=100,
                start=self.days[7], end=self.days[6],
                payment='CD', protocol='WR')
        self.charge1.save()
        self.charge2 = ChargeSession.objects.create(
                car_id=self.car, point_id=point1, pricing_id=pricing1,
                energy_delivered=20, total_cost=200,
                start=self.days[3], end=self.days[2],
                payment='CD', protocol='WR')
        self.charge2.save()
        self.charge3 = ChargeSession.objects.create(
                car_id=self.car, point_id=point2, pricing_id=pricing2,
                energy_delivered=30, total_cost=300,
                start=self.days[1], end=self.days[0],
                payment='CD', protocol='WR')
        self.charge3.save()

        self.token = self._login_and_get_token(self.user.username, "luther")

    def _elapsed(self, dt):
        return datetime.datetime.timestamp(get_now()) - datetime.datetime.timestamp(datetime_from_string(dt))

    def _verify_ev_res(self, actual, expected):
        self.assertTrue(actual.get('SessionID', False))
        self.assertEqual(int(actual['SessionID']), expected.id)

        self.assertTrue(actual.get('EnergyProvider', False) == None)

        self.assertTrue(actual.get('StartedOn', False))
        self.assertEqual(actual['StartedOn'], datetime_to_string(expected.start))

        self.assertTrue(actual.get('FinishedOn', False))
        self.assertEqual(actual['FinishedOn'], datetime_to_string(expected.end))

        self.assertTrue(actual.get('EnergyDelivered', False))
        self.assertEqual(actual['EnergyDelivered'], expected.energy_delivered)

        self.assertTrue(actual.get('PricePolicyRef', False))
        self.assertEqual(actual['PricePolicyRef'], expected.pricing_id.description)

        self.assertTrue(actual.get('CostPerKWh', False))
        self.assertEqual(actual['CostPerKWh'], expected.pricing_id.price)

        self.assertTrue(actual.get('SessionCost', False))
        self.assertEqual(actual['SessionCost'], expected.total_cost)

    def test_get_vehicle_charges(self):
        resp = self._retrieve_sessions(self._ev_url, self.token,
                self.car.licence, self.days[4], self.days[0], csv=False)

        self.assertEqual(resp.status_code, 200)
        self.assertTrue(isinstance(resp, JsonResponse))
        body = json.loads(resp.content)

        self.assertTrue(body.get('VehicleID', False))
        self.assertEqual(body['VehicleID'], self.car.licence)

        self.assertTrue(body.get('RequestTimestamp', False))
        self.assertTrue(self._elapsed(body['RequestTimestamp']) < 10000)

        self.assertTrue(body.get('PeriodFrom', False))
        self.assertEqual(body['PeriodFrom'], datetime_to_string(self._current_time(self.days[4])))

        self.assertTrue(body.get('PeriodTo', False))
        self.assertEqual(body['PeriodTo'], datetime_to_string(self._current_time(self.days[0])))

        self.assertTrue(body.get('TotalEnergyConsumed', False))
        self.assertEqual(body['TotalEnergyConsumed'], 50)

        self.assertTrue(body.get('NumberOfVisitedPoints', False))
        self.assertEqual(body['NumberOfVisitedPoints'], 2)

        self.assertTrue(body.get('NumberOfVehicleChargingSessions', False))
        self.assertEqual(body['NumberOfVehicleChargingSessions'], 2)

        self.assertTrue(body.get('VehicleChargingSessionsList', False))
        self.assertEqual(len(body['VehicleChargingSessionsList']), int(body['NumberOfVehicleChargingSessions']))

        # test first result
        first = body['VehicleChargingSessionsList'][0]
        self.assertTrue(first.get('SessionIndex', False))
        self.assertEqual(int(first['SessionIndex']), 1)

        self._verify_ev_res(first, self.charge2)

        # test second result
        second = body['VehicleChargingSessionsList'][1]
        self.assertTrue(second.get('SessionIndex', False))
        self.assertEqual(int(second['SessionIndex']), 2)

        self._verify_ev_res(second, self.charge3)

    def test_get_vehicle_charges_csv(self):
        resp = self._retrieve_sessions(self._ev_url, self.token,
                self.car.licence, self.days[4], self.days[0], csv=True)

        self.assertEqual(resp.status_code, 200)
        reader = csv.reader(resp.content.decode('utf-8').splitlines(), delimiter=",")

        items = list(reader)

        self.assertEqual(len(items), 3)
        for idx, item in enumerate(reader):
            if idx == 0:
                self.assertEqual(item,
                        ["VehicleID", "RequestTimestamp",
                        "PeriodFrom", "PeriodTo", "TotalEnergyConsumed",
                        "NumberOfVisitedPoints",
                        "NumberOfVehicleChargingSessions",
                        "SessionIndex", "SessionID", "EnergyProvider",
                        "StartedOn", "FinishedOn", "EnergyDelivered",
                        "PricePolicyRef", "CostPerKWh", "SessionCost"])
            else:
                self.assertEqual(item[0], self.car.licence)
                if idx == 1:
                    self.assertEqual(item[8], self.charge2.id)
                    self.assertEqual(item[12], self.charge2.energy_delivered)
                elif idx == 2:
                    self.assertEqual(item[8], self.charge3.id)
                    self.assertEqual(item[12], self.charge3.energy_delivered)

    def test_get_unauthorized(self):
        user2 = self._create_user("someone", "else")
        token2 = self._login_and_get_token(user2.username, "else")

        resp = self._retrieve_sessions(self._ev_url, token2,
                self.car.licence, self.days[4], self.days[0], csv=False)

        # should be unauthorized
        self.assertEqual(resp.status_code, 401)
        self.assertTrue(isinstance(resp, HttpResponse))

    def test_invalid_dates(self):
        resp = self._retrieve_sessions(self._ev_url, self.token,
                self.car.licence, self.days[5], self.days[4], csv=False)

        self.assertEqual(resp.status_code, 200)
        self.assertTrue(isinstance(resp, JsonResponse))
        body = json.loads(resp.content)

        self.assertTrue(body.get('VehicleID', False))
        self.assertEqual(body['VehicleID'], self.car.licence)

        self.assertTrue(body.get('RequestTimestamp', False))
        self.assertTrue(self._elapsed(body['RequestTimestamp']) < 10000)

        self.assertTrue(body.get('PeriodFrom', False))
        self.assertEqual(body['PeriodFrom'], datetime_to_string(self._current_time(self.days[5])))

        self.assertTrue(body.get('PeriodTo', False))
        self.assertEqual(body['PeriodTo'], datetime_to_string(self._current_time(self.days[4])))

        self.assertTrue(body.get('TotalEnergyConsumed', False) == 0)

        self.assertTrue(body.get('NumberOfVisitedPoints', False) == 0)

        self.assertTrue(body.get('NumberOfVehicleChargingSessions', False) == 0)

        self.assertTrue(body.get('VehicleChargingSessionsList', False) == [])

    def test_invalid_date_format(self):
        resp = self.client.get(self._ev_url(self.car.licence,
            datetime_to_string(self.days[7]), "invalid_format"),
            HTTP_X_AUTH_OBSERVATORY=self.token)
        self.assertEqual(resp.status_code, 400)

        resp = self.client.get(self._ev_url(self.car.licence,
            "invalid_format", datetime_to_string(self.days[0])),
            HTTP_X_AUTH_OBSERVATORY=self.token)
        self.assertEqual(resp.status_code, 400)

    def test_invalid_car_id(self):
        resp = self._retrieve_sessions(self._ev_url, self.token,
                "idonotexisthahah", self.days[7], self.days[0], csv=False)

        self.assertEqual(resp.status_code, 400)
        self.assertTrue(isinstance(resp, HttpResponseBadRequest))
