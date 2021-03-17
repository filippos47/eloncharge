from unittest import mock

from base import TestBase
from cli.methods.system import healthcheck, resetsessions, sessionupd
from cli.utils.common import produce_url

class SystemTest(TestBase):
    def test_healthcheck(self):
        args = self.Arguments()

        resp = self.Response("okok")
        with mock.patch("requests.get", return_value=resp) as mock_reqs:
            r = healthcheck(args)
            # returns the text we provided
            self.assertEqual(r, resp.text)
            mock_reqs.assert_called_with(produce_url(["admin", "healthcheck"]),
                    data={}, headers=self._get_header())

    def test_resetsessions(self):
        args = self.Arguments()

        resp = self.Response("okok")
        with mock.patch("requests.delete", return_value=resp) as mock_reqs:
            r = resetsessions(args)

            self.assertEqual(r, resp.text)
            mock_reqs.assert_called_with(produce_url(["admin", "resetsessions"]),
                    data={}, headers=self._get_header())
