import json

from django.test import TestCase
from django.contrib.auth.models import User
from django.http import JsonResponse, HttpResponse
from django.core.exceptions import ObjectDoesNotExist

from .base import TestBase

class UserViewTest(TestBase):
    def setUp(self):
        self.admin = self._create_user("admin", "adminpass",
                "admin@here.com")
        self.admin.is_superuser = True
        self.admin.save()
        self.token = self._login_and_get_token(self.admin.username, "adminpass")
        self.username = "ninja"
        self.password = "turtle"

    def test_creation(self):
        resp = self._update_user(self.username, self.password, self.token)

        self.assertEqual(resp.status_code, 200)
        self.assertTrue(isinstance(resp, HttpResponse))

        # attempt to retrieve user, this will fail if user not created
        user = User.objects.get(username=self.username)
        self.assertTrue(user.check_password(self.password))

    def test_change_pass(self):
        new_password = "new_password"
        self._create_user(self.username, self.password)

        resp = self._update_user(self.username, new_password, self.token)

        # simple success
        self.assertEqual(resp.status_code, 200)
        self.assertTrue(isinstance(resp, HttpResponse))

        user = User.objects.get(username=self.username)

        # old password should fail
        self.assertFalse(user.check_password(self.password))
        # new password should not fail
        self.assertTrue(user.check_password(new_password))

    def test_creation_no_token(self):
        resp = self.client.post(self._usermod_url(self.username, self.password))

        # Unauthorized
        self.assertEqual(resp.status_code, 401)

        # user should have not been created
        with self.assertRaises(ObjectDoesNotExist):
            User.objects.get(username=self.username)

    def test_access_unauthenticated(self):
        new_password = "new_password"

        resp = self._update_user(self.username, self.password, "falsetoken")

        # no token => unauthorized
        self.assertEqual(resp.status_code, 401)

        # user should have not been created
        with self.assertRaises(ObjectDoesNotExist):
            User.objects.get(username=self.username)

    def test_retrieval(self):
        self._create_user(self.username, self.password)
        user_token = self._login_and_get_token(self.username, self.password)

        resp = self._retrieve_user(self.username, self.token)

        body = json.loads(resp.content)
        self.assertEqual(resp.status_code, 200)
        self.assertTrue(body.get('username', False))
        self.assertEqual(body['username'], self.username)

        # user should be able to retrieve their own characteristics
        resp = self._retrieve_user(self.username, user_token)
        self.assertEqual(resp.status_code, 200)
        self.assertTrue(body.get('username', False))
        self.assertEqual(body['username'], self.username)

    def test_retrieval_non_existent_user(self):
        resp = self._retrieve_user("idonotexisthahah", self.token)

        self.assertEqual(resp.status_code, 402)

    def test_retrieval_no_token(self):
        self._create_user(self.username, self.password)

        resp = self.client.get(self._usershow_url(self.username))

        self.assertEqual(resp.status_code, 401)

    def test_retrieval_unauthenticated(self):
        self._create_user(self.username, self.password)

        resp = self._retrieve_user(self.username, "afalsetoken")
        self.assertEqual(resp.status_code, 401)
