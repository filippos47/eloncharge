from unittest import mock

from base import TestBase
from cli.utils.common import (
        produce_url, place_request,
        create_token_file, delete_token_file,
)

from cli.utils.constants import BASE_URL

class UtilsTest(TestBase):
    def test_produce_url(self):
        url_service_only = BASE_URL + 'login'
        url_service_list_only = BASE_URL + 'admin/healthcheck'
        url_resource = BASE_URL + 'SessionsPerStation/1'
        url_resource_list = BASE_URL + 'SessionsPerStation/1/2/3'
        url_format = BASE_URL + 'login?format=sio'
        url_resource_and_format = BASE_URL + 'SessionsPerStation/1?format=sio'
        url_resource_list_and_format = BASE_URL + \
                'SessionsPerStation/1/2/3?format=sio'
        url_service_list_and_resource_list_and_format = BASE_URL + \
                'admin/usermod/koko/lala?format=sio'

        self.assertEqual(url_service_only, produce_url(['login']))
        self.assertEqual(url_service_list_only,
                produce_url(['admin', 'healthcheck']))
        self.assertEqual(url_resource,
                produce_url(['SessionsPerStation'], ['1']))
        self.assertEqual(url_resource_list,
                produce_url(['SessionsPerStation'], ['1', '2', '3']))
        self.assertEqual(url_format, produce_url(['login'], requested_format='sio'))
        self.assertEqual(url_resource_and_format,
                produce_url(['SessionsPerStation'], ['1'], 'sio'))
        self.assertEqual(url_resource_list_and_format,
                produce_url(['SessionsPerStation'], ['1', '2', '3'], 'sio'))
        self.assertEqual(url_service_list_and_resource_list_and_format,
                produce_url(['admin', 'usermod'], ['koko', 'lala'], 'sio'))

    def test_create_token_file(self):
        token = "koko"

        with mock.patch('builtins.open', mock.mock_open()) as mock_file:
            create_token_file(token)
            handle = mock_file()
            handle.write.assert_called_once_with(token)
