import requests

from ev_group53.utils.common import produce_url

def sessions_per_station(args):
    url = produce_url(
            ["SessionsPerStation"],
            [args.station, args.datefrom, args.dateto],
            args.format)
    headers = {'X-AUTH-OBSERVATORY': args.apikey}
    response = requests.get(url, headers=headers)
    print(response.text)
