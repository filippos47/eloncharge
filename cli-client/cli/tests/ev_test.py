from unittest import mock

from base import TestBase
from cli.methods.ev import sessions_per_ev
from cli.utils.common import produce_url

class EVTest(TestBase):
    def test_login(self):
        args = self.Arguments(ev='1', datefrom='2020-03-30 23:49:39',
                dateto='2020-03-30 23:49:39', format="json", apikey="koko")

        resp = self.Response("okok")
        with mock.patch("requests.get", return_value=resp) as mock_reqs:
            r = sessions_per_ev(args)
            self.assertEqual(r, resp.text)
            mock_reqs.assert_called_with(produce_url(["SessionsPerEV"],
                    [args.ev, args.datefrom, args.dateto], args.format),
                    data={}, headers=self._get_header(args.apikey))
