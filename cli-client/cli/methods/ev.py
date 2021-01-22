from cli.utils.common import produce_url, place_request

def sessions_per_ev(args):
    url = produce_url(
            ["SessionsPerEV"],
            [args.ev, args.datefrom, args.dateto],
            args.format)
    response = place_request("get", url, token=args.apikey)
    return response.text
