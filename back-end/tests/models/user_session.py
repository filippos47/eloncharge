from django.test import TransactionTestCase
from django.contrib.auth.models import User
from django.db import IntegrityError
from api.models import UserSession

from api.models import UserSession
from api.utils.common import create_auth_token, token_expires_delta, get_now

class UserSessionTest(TransactionTestCase):
    def setUp(self):
        self.user = User.objects.create(username="ninja",
                password="turtle", email="ninja@turtle.com")

    def test_expiration(self):
        token = create_auth_token()
        expires = get_now() - token_expires_delta()
        session = UserSession.objects.create(user_id=self.user, token=token, expires=expires)
        session.save()
        # Check that session has expired
        self.assertTrue(session.has_expired())

        expires = get_now() + token_expires_delta()
        token = create_auth_token()
        session = UserSession.objects.create(user_id=self.user, token=token, expires=expires)
        session.save()

        # check for session that has not expired
        self.assertFalse(session.has_expired())

    def test_unique_token(self):
        token = create_auth_token()
        expires = get_now() - token_expires_delta()
        session = UserSession.objects.create(user_id=self.user, token=token, expires=expires)
        session.save()

        # check that integrity error raised for duplicate token
        with self.assertRaises(IntegrityError):
            session = UserSession.objects.create(user_id=self.user, token=token, expires=expires)
