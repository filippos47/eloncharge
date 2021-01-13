import random
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
STATIONS_PER_USER = 2
CHARGE_SESSIONS_PER_CAR = 3
CITIES = [["Pefki", 38.058970, 23.791150],
          ["Keratsini", 37.975340, 23.736150],
          ["Agios Stefanos", 37.996860, 23.747530],
          ["Ampelokipoi", 37.975340, 23.736150],
          ["Piraeus", 37.9431594, 23.6470593],
          ["Nea Filadelfeia", 38.0435089, 23.7458365],
          ["Ano Liosia", 38.0978801, 23.6958265],
          ["Pagkrati", 37.9667105, 23.747913],
          ["Nea Chalkidona", 38.0253017, 23.7279355],
          ["Melissia", 38.0491855, 23.8352653],
          ["Nea Ionia", 38.03934125, 23.75757814],
          ["Exarcheia", 37.9859917, 23.7355410]]
ADDRESSES = ["Kyklaminwn", "Vederiotaki", "Thiseos", "Anthewn", "Billysiotakh",
             "Aidiniou", "Kalyftaki", "Nikodimou", "Chiligiri", "Madclipoglou",
             "Arxigou", "Virwnos"]

class Command(BaseCommand):
    help = "Populate database"
    requires_migration_checks = True

    def add_arguments(self, parser):
        pass

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
        for user in users:
            for i in range(CARS_PER_USER):
                car = Car(
                    user_id=user,
                    licence=fake.license_plate(),
                    brand=fake.vehicle_make(),
                    model=fake.vehicle_model(),
                    release=fake.date(),
                    consumption=random.randint(5, 15),
                    type=fake.vehicle_category()
                )
                car.save()
                cars.append(car)

        # stations
        stations = []
        for user in users:
            for i in range(STATIONS_PER_USER):
                place = random.choice(CITIES)
                CITIES.remove(place)
                street = random.choice(ADDRESSES)
                ADDRESSES.remove(street)
                station = Station(
                    latitude=place[1],
                    longtitude=place[2],
                    address=street,
                    number=fake.building_number(),
                    zipcode=fake.postcode(),
                    city=place[0],
                    region="Attica",
                    country="Greece",
                    operator=user
                )
                station.save()
                stations.append(station)

        # pricing schemes
        for station in stations:
            for i in range(random.randint(1, 3)):
                pricing = Pricing(
                    station_id=station,
                    description=fake.text(),
                    price=random.randint(1, 3)
                )
                pricing.save()

        # points
        points = []
        for station in stations:
            for i in range(random.randint(1, 3)):
                point = Point(
                    station_id=station
                )
                point.save()
                points.append(point)

        for car in cars:
            for i in range(CHARGE_SESSIONS_PER_CAR):
                point = random.choice(points)
                station = point.station_id
                pricing = random.choice(Pricing.objects.filter(station_id=station))

                charge_session = ChargeSession(
                    car_id=car,
                    point_id=point,
                    pricing_id=pricing,
                    energy_delivered=random.randint(3, 50),
                    total_cost=random.randint(20, 50),
                    start=fake.date_time_between(start_date='-30d',
                        end_date='-29d', tzinfo=timezone('Europe/Athens')),
                    end=fake.date_time_between(start_date='-29d',
                        end_date='-28d', tzinfo=timezone('Europe/Athens')),
                    payment=random.choice(['CD', 'CH']),
                    protocol=random.choice(['WR', 'WD'])
                )
                charge_session.save()
