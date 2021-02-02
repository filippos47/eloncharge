import os

from cli.methods.session import login, logout
from cli.methods.user import usermod, users
from cli.methods.system import healthcheck, sessionupd, resetsessions
from cli.methods.point import sessions_per_point
from cli.methods.station import sessions_per_station
from cli.methods.ev import sessions_per_ev
from .common import generate_token_filepath

METHOD_MAP = {'healthcheck': healthcheck,
              'resetsessions': resetsessions,
              'login': login,
              'logout': logout,
              'SessionsPerPoint': sessions_per_point,
              'SessionsPerStation': sessions_per_station,
              'SessionsPerEV': sessions_per_ev}

def method_caller(args):
    if args.command != "Admin":
        response_text = METHOD_MAP[args.command](args)
    else:
        if args.usermod:
            response_text = usermod(args)
        elif args.users:
            response_text = users(args)
        elif args.sessionupd:
            response_text = sessionupd(args)
        elif args.healthcheck:
            response_text = healthcheck(args)
        elif args.resetsessions:
            response_text = resetsessions(args)

    return response_text

def broken_admin_dependencies(args):
    usermod_violation = (args.usermod == True and
                         (args.username == None or args.passw == None))
    sessionupd_violation = (args.sessionupd == True and
                            args.source == None)

    if usermod_violation or sessionupd_violation:
        return True
    return False

def apikey_present_if_required(args):
    if args.command not in ['healthcheck', 'resetsessions', 'login'] and \
            args.apikey == None:
        token_filepath = generate_token_filepath()

        try:
            token_filesize = os.path.getsize(token_filepath)
        except OSError:
            return False
        if token_filesize == 0:
            return False

        with open(token_filepath, "r") as fp:
            args.apikey = fp.readline()

    return True
