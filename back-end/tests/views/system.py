import json

from django.http import JsonResponse
from django.contrib.auth.models import User

from .base import TestBase
from api.models import ChargeSession
from api.utils.common import get_now

class SystemViewTest(TestBase):
    def setUp(self):
        self.default_pass = "petrol4ever"

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
        self._create_user("admin", old_pass)
        resp = self.client.delete(self._reset_url())

        user = User.objects.get(username="admin")

        self.assertFalse(user.check_password(old_pass))
        self.assertTrue(user.check_password(self.default_pass))

        # all charge sessions deleted
        self.assertEqual(len(ChargeSession.objects.all()), 0)

    def test_session_upload(self):
        # TODO
        self.fail("Implement me!")

    # TODO
    """
    def test_session_upload_same_sessions(self):
        self.fail("Implement me")

    def test_session_upload_new_sessions(self):
        self.fail("Implement me")
    """
