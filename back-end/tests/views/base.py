import json
import pytz
import datetime

from django.test import TestCase
from django.urls import reverse
from django.conf import settings
from django.contrib.auth.models import User

from api.utils.common import datetime_to_string, get_now

class TestBase(TestCase):
    def _login_url(self):
        return reverse("session_login")

    def _logout_url(self):
        return reverse("session_logout")

    def _usermod_url(self, username, password):
        return reverse("user_create", args=[username, password])

    def _usershow_url(self, username):
        return reverse("user_show", args=[username])

    def _healthcheck_url(self):
        return reverse("system_healthcheck")

    def _reset_url(self):
        return reverse("system_resetsessions")

    def _ev_url(self, ev_id, start, end):
        return reverse("ev_sessions", args=[ev_id, start, end])

    def _point_url(self, point_id, start, end):
        return reverse("point_sessions", args=[point_id, start, end])

    def _station_url(self, station_id, start, end):
        return reverse("station_sessions", args=[station_id, start, end])

    def _create_user(self, username, password, email="my@mail.gov", is_superuser=False):
        user = User.objects.create(username=username,
                email=email)
        user.set_password(password)
        user.save()
        return user

    def _get_prev_days(self, days):
        return get_now() - datetime.timedelta(days=days)

    def _login(self, username, password):
        return self.client.post(self._login_url(),
                "username="+username+"&password="+password,
                content_type="application/x-www-form-urlencoded")

    def _extract_token(self, resp):
        return json.loads(resp.content)['token']

    def _login_and_get_token(self, username, password):
        return self._extract_token(self._login(username, password))

    def _logout(self, token):
        return self.client.post(self._logout_url(), HTTP_X_AUTH_OBSERVATORY=token)

    def _update_user(self, username, password, token):
        return self.client.post(self._usermod_url(username, password),
                    HTTP_X_AUTH_OBSERVATORY=token)

    def _retrieve_user(self, username, token):
        return self.client.get(self._usershow_url(username),
                    HTTP_X_AUTH_OBSERVATORY=token)

    def _current_time(self, dt):
        curr_tz = datetime.datetime.now(pytz.timezone(settings.TIME_ZONE))
        offset = curr_tz.utcoffset().total_seconds() / 60 / 60

        return dt + datetime.timedelta(hours=offset)

    def _retrieve_sessions(self, url, token, id, fr, to, csv=False):
        fr = datetime_to_string(self._current_time(fr))
        to = datetime_to_string(self._current_time(to))

        format = "json"
        if csv:
            format = "csv"

        return self.client.get(url(id, fr, to) + "?format="+format,
                    HTTP_X_AUTH_OBSERVATORY=token)
