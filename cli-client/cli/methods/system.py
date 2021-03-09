from cli.utils.common import produce_url, place_request

def healthcheck(args):
    url = produce_url(["admin", "healthcheck"])
    response = place_request("get", url)
    return response.text

def sessionupd(args):
    source = args.source
    token = args.apikey

    url = produce_url(["admin", "system", "sessionupd"])
    with open(args.source, "r") as f:
        response = place_request("post", url, files={"file": f}, token=token)
    return response.text

def resetsessions(args):
    url = produce_url(["admin", "resetsessions"])
    response = place_request("delete", url)
    return response.text
