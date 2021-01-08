import json

from django.contrib.auth.models import User
from django.http import JsonResponse, HttpResponse

from api.models import UserSession
from api.utils.common import get_now

from .base import TestBase

class LoginViewTest(TestBase):
    def setUp(self):
        self.username = "martin"
        self.password = "luther"
        self.user = self._create_user(self.username, self.password)

    def test_login_valid(self):
        resp = self._login(self.username, self.password)

        self.assertEqual(resp.status_code, 200)
        self.assertTrue(isinstance(resp, JsonResponse))
        body = json.loads(resp.content)
        self.assertTrue(body.get("token", False))

        # check session object
        session = UserSession.objects.get(token=body['token'])
        self.assertTrue(session.expires > get_now())
        self.assertEquals(session.user_id, self.user)

    def test_login_invalid_password(self):
        resp = self._login(self.username, "imwrong!@!")

        self.assertEqual(resp.status_code, 401)
        self.assertTrue(isinstance(resp, HttpResponse))

    def test_login_non_existent_user(self):
        resp = self._login("idonotexisthahah", self.password)

        self.assertEqual(resp.status_code, 401)
        self.assertTrue(isinstance(resp, HttpResponse))

    def test_login_existing_token(self):
        # retrieve token
        token1 = self._login_and_get_token(self.username, self.password)

        # redo request and check that the token remains the same
        token2 = self._login_and_get_token(self.username, self.password)
        self.assertEqual(token1, token2)

class LogoutViewTest(TestBase):
    def setUp(self):
        self.username = "martin"
        self.password = "luther"
        self.user = self._create_user(self.username, self.password)

    def test_logout_valid(self):
        token = self._login_and_get_token(self.username, self.password)
        resp = self._logout(token)

        self.assertEqual(resp.status_code, 200)
        self.assertEqual(len(resp.content), 0)

        session = UserSession.objects.get(token=token)
        self.assertTrue(session.expires < get_now())

    def test_logout_without_token(self):
        resp = self.client.post(self._logout_url())

        self.assertEqual(resp.status_code, 401)

    def test_logout_invalid_token(self):
        resp = self._logout("idonotexisthahah")

        self.assertEqual(resp.status_code, 401)
