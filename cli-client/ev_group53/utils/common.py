from os.path import expanduser
from os import remove

from .constants import BASE_URL, TOKEN_FILENAME

def produce_url(service, path_to_resource=None, requested_format=None):
    url = BASE_URL + "/".join(service)
    if path_to_resource:
        url += "/" + "/".join(path_to_resource)
    if requested_format:
        url += "?format=" + requested_format

    return url

def create_token_file(token):
    token_filepath = expanduser("~") + "/" + TOKEN_FILENAME
    with open(token_filepath, "w") as fp:
        fp.write(token)

def delete_token_file():
    token_filepath = expanduser("~") + "/" + TOKEN_FILENAME
    try:
        remove(token_filepath)
    except OSError:
        pass
