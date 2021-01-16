import requests

from ev_group53.utils.common import produce_url

def healthcheck(args):
    url = produce_url(["admin", "healthcheck"])
    response = requests.get(url)
    print(response.text)

def sessionupd(args):
    print("sessionupd")

def resetsessions(args):
    url = produce_url(["admin", "resetsessions"])
    response = requests.get(url)
    print(response.text)
