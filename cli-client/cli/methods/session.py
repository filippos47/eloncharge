from cli.utils.common import (
        produce_url, place_request,
        create_token_file, delete_token_file,
)

def login(args):
    url = produce_url(['login'])
    data = {'username': args.username, 'password': args.passw}
    response = place_request("post", url, data=data)
    create_token_file(response.json()["token"])
    return response.text

def logout(args):
    url = produce_url(['logout'])
    response = place_request("post", url, token=args.apikey)
    delete_token_file()
    return response.text
