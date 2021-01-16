import requests

from ev_group53.utils.common import (
        produce_url,
        create_token_file, delete_token_file,
)

def login(args):
    url = produce_url(['login'])
    data = {'username': args.username, 'password': args.passw}
    response = requests.post(url, data=data)
    create_token_file(response.json()["token"])
    print(response.text)

def logout(args):
    url = produce_url(['logout'])
    headers = {'X-AUTH-OBSERVATORY': args.apikey}
    response = requests.post(url, headers=headers)
    delete_token_file()
    print(response.text)
