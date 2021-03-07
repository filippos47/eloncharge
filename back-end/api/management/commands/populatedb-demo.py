import random
import datetime
from pytz import timezone

from faker import Faker
from faker_vehicle import VehicleProvider
from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model
from django.contrib.auth.hashers import make_password

from api.models import (
    Car,
    Point,
    Pricing,
    Station,
    ChargeSession,
)

USERS = 2
CARS_PER_USER = 2
STATIONS_PER_USER = 5
CHARGE_SESSIONS_PER_CAR = random.randint(5, 15)
POINTS_PER_STATION = random.randint(2, 4)

# Latitude, Longtitude, Address, Number, Zipcode, City
STATIONS = [["38.05949907359015", "23.78756308974072", "Leoforos Eirinis", "53", "15121", "Pefki"],
            ["38.11965411202746", "23.857860528706954", "Leoforos Marathwnos", "10", "14569", "Drosia"],
            ["37.95926272048575", "23.615749635453312", "Leoforos Dimokratias", "132", "18756", "Keratsini"],
            ["38.050580129610026", "23.76473209312465", "Leoforos Irakleioy", "388-390", "14122", "Irakleio"],
            ["37.98854473330098", "23.763610728706777", "Leoforos Kifisias", "34", "11526", "Ampelokipoi"],
            ["38.119084482991894", "23.823922406478125", "SEA", "Varimpompis", "14671", "Nea Erithraia"],
            ["37.986598667856775", "23.73448064249625", "Spirou Trikoupi", "3", "10683", "Exarcheia"],
            ["38.041298981745726", "23.688213063498598", "Kosta Varnali", "70", "13231", "Petroupoli"],
            ["37.871181514356174", "23.758470864288803", "Paradromos Leoforou Vouliagmenis", "96", "16675", "Glifada"],
            ["38.01819548661664", "23.803064271035588", "Palaiologou", "85", "15232", "Chalandri"]]

BRANDS = ["Mercedes-Benz", "Chevrolet", "BMW", "Nissan",
         "Ford", "Lexus", "Jaguar", "Tesla"]
MODELS = ["EQC", "Spark EV", "i3", "Leaf",
          "Focus Electric", "UX 300e", "I-Pace", "Model S"]

class Command(BaseCommand):
    requires_migration_checks = True

    def handle(self, *args, **options):
        fake = Faker()
        fake.add_provider(VehicleProvider)

        # users
        User = get_user_model()
        users = []
        for i in range(USERS):
            uname = fake.simple_profile()['username']
            passw = fake.password(length=20)
            user = User(
                username=uname,
                password=make_password(passw),
                first_name=fake.first_name(),
                last_name=fake.last_name(),
                email=fake.email()
            )
            print(uname, passw)
            user.save()
            users.append(user)

        # cars
        cars = []
        user_cnt = 0
        for user in users:
            for i in range(CARS_PER_USER):
                car = Car(
                    user_id=user,
                    licence=fake.license_plate(),
                    brand=BRANDS[user_cnt + i],
                    model=MODELS[user_cnt + i],
                    release=fake.date_between(start_date='-2y'),
                    consumption=random.randint(5, 15),
                    type=fake.vehicle_category()
                )
                car.save()
                cars.append(car)
            user_cnt += CARS_PER_USER

        # stations
        stations = []
        user_cnt = 0
        for user in users:
            for i in range(STATIONS_PER_USER):
                STATION = STATIONS[user_cnt + i]
                station = Station(
                    latitude=STATION[0],
                    longtitude=STATION[1],
                    address=STATION[2],
                    number=STATION[3],
                    zipcode=STATION[4],
                    city=STATION[5],
                    region="Attica",
                    country="Greece",
                    operator=user
                )
                station.save()
                stations.append(station)
            user_cnt += STATIONS_PER_USER

        # pricing schemes
        for station in stations:
            for i in range(random.randint(1, 3)):
                pricing = Pricing(
                    station_id=station,
                    description=fake.text(),
                    price=round(random.uniform(1, 3), 3)
                )
                pricing.save()

        # points
        points = []
        for station in stations:
            for i in range(random.randint(2, 6)):
                point = Point(
                    station_id=station
                )
                point.save()
                points.append(point)

        for car in cars:
            for i in range(random.randint(10, 20)):
                point = random.choice(points)
                station = point.station_id
                pricing = random.choice(Pricing.objects.filter(station_id=station))
                charge_start = fake.date_time_between(start_date='-60d',
                        end_date='-2d', tzinfo=timezone('Europe/Athens'))
                charge_end = charge_start + datetime.timedelta(hours=random.randint(3, 12), seconds=random.randint(1, 59))

                charge_session = ChargeSession(
                    car_id=car,
                    point_id=point,
                    pricing_id=pricing,
                    energy_delivered=round(random.uniform(3, 50), 3),
                    total_cost=round(random.uniform(20, 50), 2),
                    start=charge_start,
                    end=charge_end,
                    payment=random.choice(['CD', 'CH']),
                    protocol=random.choice(['WR', 'WD'])
                )
                charge_session.save()
