from os.path import expanduser
from os import remove
import requests

from .constants import BASE_URL, TOKEN_FILENAME

def produce_url(service, path_to_resource=None, requested_format=None):
    url = BASE_URL + "/".join(service)
    if path_to_resource:
        url += "/" + "/".join(path_to_resource)
    if requested_format:
        url += "?format=" + requested_format

    return url

def generate_token_filepath():
    return expanduser("~") + "/" + TOKEN_FILENAME

def create_token_file(token):
    token_filepath = generate_token_filepath()
    with open(token_filepath, "w") as fp:
        fp.write(token)

def delete_token_file():
    token_filepath = generate_token_filepath()
    try:
        remove(token_filepath)
    except OSError:
        pass

def place_request(method, url, data={}, token=None):
    headers = {}
    if token:
        headers = {'X-AUTH-OBSERVATORY': token}

    requests_method = getattr(requests, method)
    response = requests_method(url, data=data, headers=headers)
    return response
