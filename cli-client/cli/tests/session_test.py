from unittest import mock

from base import TestBase
from cli.methods.session import login, logout
from cli.utils.common import produce_url

class SessionTest(TestBase):
    def test_login(self):
        args = self.Arguments(username="billy", passw="sio")

        resp = self.Response({"token": "koko"})
        with mock.patch("requests.post", return_value=resp) as mock_reqs:
            r = login(args)
            self.assertEqual(r, resp.text)
            mock_reqs.assert_called_with(produce_url(["login"]),
                    data={'username': args.username, 'password': args.passw},
                    headers=self._get_header())

    def test_resetsessions(self):
        args = self.Arguments(apikey="koko")

        resp = self.Response("okok")
        with mock.patch("requests.post", return_value=resp) as mock_reqs:
            r = logout(args)

            self.assertEqual(r, resp.text)
            mock_reqs.assert_called_with(produce_url(["logout"]),
                    data={}, headers=self._get_header(args.apikey))
