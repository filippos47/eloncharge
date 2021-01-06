from django.test import TestCase
from django.contrib.auth.models import User
from django.core.exceptions import ObjectDoesNotExist

from api.models import Car

class CarTest(TestCase):
    def setUp(self):
        self.user = User.objects.create(username="Sherlock",
                password="Holmes", email="sherlock@detective.com")

    def test_creation(self):
        # simple creation
        car = Car.objects.create(user_id=self.user, licence="221B")
        car.save()

        # creation without licence
        Car.objects.create(user_id=self.user)

    def test_attr_deletion(self):
        car = Car.objects.create(user_id=self.user, licence="221B")
        car.save()
        self.user.delete()

        # when the user is deleted, the car should be deleted too
        with self.assertRaises(ObjectDoesNotExist):
            car = Car.objects.get(licence="221B")
