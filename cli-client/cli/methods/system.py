from cli.utils.common import produce_url, place_request

def healthcheck(args):
    url = produce_url(["admin", "healthcheck"])
    response = place_request("get", url)
    return response.text

def sessionupd(args):
    print("sessionupd")

def resetsessions(args):
    url = produce_url(["admin", "resetsessions"])
    response = place_request("post", url)
    return response.text
