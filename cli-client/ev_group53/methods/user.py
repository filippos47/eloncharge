from ev_group53.utils.common import produce_url, place_request

def usermod(args):
    url = produce_url(
            ['admin', 'usermod'],
            [args.username, args.passw]
    )
    response = place_request("post", url, token=args.apikey)
    return response.text

def users(args):
    url = produce_url(
            ['admin', 'users'],
            [args.users]
    )
    response = place_request("get", url, token=args.apikey)
    return response.text
