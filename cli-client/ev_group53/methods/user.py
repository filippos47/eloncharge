import requests
import re
from sys import exit

from ev_group53.utils.common import produce_url

def usermod(args):
    if re.match('^[a-zA-Z0-9]+$', args.username) == None:
        exit("Username must only contain alphanumeric characters.")
    elif args.passw == "":
        exit("Password must not be an empty string!")
    else:
        url = produce_url(
                ['admin', 'usermod'],
                [args.username, args.passw]
        )
        headers = {'X-AUTH-OBSERVATORY': args.apikey}
        response = requests.post(url, headers=headers)
        print(response.text)

def users(args):
    if re.match('^[a-zA-Z0-9]+$', args.users) == None:
        exit("Username must only contain alphanumeric characters.")
    else:
        url = produce_url(
                ['admin', 'users'],
                [args.users]
        )
        headers = {'X-AUTH-OBSERVATORY': args.apikey}
        response = requests.get(url, headers=headers)
        print(response.text)
