from unittest import mock

from base import TestBase
from cli.methods.user import usermod, users
from cli.utils.common import produce_url

class UserTest(TestBase):
    def test_usermod(self):
        args = self.Arguments(username="goofy", passw="goofer", apikey="wtf")

        resp = self.Response("hihi")
        with mock.patch("requests.post", return_value=resp) as mock_reqs:
            r = usermod(args)
            # returns the text we provided
            self.assertEqual(r, resp.text)
            mock_reqs.assert_called_with(produce_url(["admin", "usermod"], [args.username, args.passw]),
                    data={}, headers=self._get_header(args.apikey))

    def test_users(self):
        args = self.Arguments(users="billy", apikey="koko")

        resp = self.Response("okok")
        with mock.patch("requests.get", return_value=resp) as mock_reqs:
            r = users(args)

            self.assertEqual(r, resp.text)
            mock_reqs.assert_called_with(produce_url(["admin", "users"], [args.users]),
                    data={}, headers=self._get_header(args.apikey))
