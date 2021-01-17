from ev_group53.utils.common import produce_url, place_request

def sessions_per_station(args):
    url = produce_url(
            ["SessionsPerStation"],
            [args.station, args.datefrom, args.dateto],
            args.format)
    response = place_request("get", url, token=args.apikey)
    return response.text
