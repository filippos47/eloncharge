from random import randint

from faker import Faker
from faker_vehicle import VehicleProvider
from django.core.management.base import BaseCommand
from django.contrib.auth import get_user_model

from api.models import (
    Car,
    Point,
    Pricing,
    Station,
)

class Command(BaseCommand):
    help = "Populate database with N random cars, stations, charging points " \
           "and pricing schemes"
    requires_migration_checks = True

    def add_arguments(self, parser):
        parser.add_argument('count',
            default=50,
            type=int)

    def handle(self, *args, **options):
        fake = Faker()
        fake.add_provider(VehicleProvider)
        N = options['count']

        User = get_user_model()
        rand_user = User.objects.get(username='admin')

        # cars
        for i in range(N):
            car = Car(
                user_id=rand_user,
                licence=fake.license_plate(),
                brand=fake.vehicle_make(),
                model=fake.vehicle_model(),
                release=fake.date(),
                consumption=randint(5, 15),
                type=fake.vehicle_category()
            )
            car.save()

        # stations
        stations = []
        for i in range(N // 10):
            station = Station(
                    latitude=fake.latitude(),
                    longtitude=fake.longitude(),
                    address=fake.street_name(),
                    number=fake.building_number(),
                    zipcode=fake.postcode(),
                    city=fake.city(),
                    region=fake.country_code(),
                    country=fake.country(),
                    operator=rand_user
            )
            station.save()
            stations.append(station)

        # pricing schemes
        for station in stations:
            for i in range(randint(1,5)):
                pricing = Pricing(
                        station_id=station,
                        description=fake.text(),
                        price=randint(5, 10)
                )
                pricing.save()

        # points
        for station in stations:
            for i in range(randint(5,10)):
                point = Point(
                      station_id=station
                )
                point.save()
