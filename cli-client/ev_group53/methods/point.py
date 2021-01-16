import requests

from ev_group53.utils.common import produce_url

def sessions_per_point(args):
    url = produce_url(
            ["SessionsPerPoint"],
            [args.point, args.datefrom, args.dateto],
            args.format)
    headers = {'X-AUTH-OBSERVATORY': args.apikey}
    response = requests.get(url, headers=headers)
    print(response.text)
