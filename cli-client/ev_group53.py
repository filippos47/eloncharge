import argparse
import sys

from functions.login import login
from functions.logout import logout
from functions.user import usermod, users
from functions.system import healthcheck, sessionupd, resetsessions
from functions.point import sessions_per_point
from functions.station import sessions_per_station
from functions.ev import sessions_per_ev

FUNCTION_MAP = {'healthcheck': healthcheck,
                'resetsessions': resetsessions,
                'login': login,
                'logout': logout,
                'SessionsPerPoint': sessions_per_point,
                'SessionsPerStation': sessions_per_station,
                'SessionsPerEV': sessions_per_ev}

def function_caller(args):
    if args.command != "Admin":
        FUNCTION_MAP[args.command](args)
    else:
        if args.usermod:
            usermod(args)
        elif args.users:
            users(args)
        elif args.sessionupd:
            sessionupd(args)
        elif args.healthcheck:
            healthcheck(args)
        elif args.resetsessions:
            resetsessions(args)

def broken_admin_dependencies(args):
    usermod_violation = (args.usermod == True and
                         (args.username == None or args.passw == None))
    sessionupd_violation = (args.sessionupd == True and
                            args.source == None)

    if usermod_violation or sessionupd_violation:
        return True
    return False

def main():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(help="Available functionalities",
        dest="command")
   
    parent_parser = argparse.ArgumentParser(add_help=False)
    parent_parser.add_argument(
        "--format",
        help="select desired output format (supported: csv, json)",
        choices=["csv", "json"],
        required=True
    )
    parent_parser.add_argument(
        "--apikey",
        help="provide API token",
        required=True
    )

    healthcheck_parser = subparsers.add_parser("healthcheck",
        help="perform system healthcheck",
        parents=[parent_parser])

    resetsessions_parser = subparsers.add_parser("resetsessions",
        help="reset charge sessions",
        parents=[parent_parser])

    login_parser = subparsers.add_parser("login",
        help="login using your credentials",
        parents=[parent_parser])
    login_parser.add_argument(
        "--username",
        help="enter your username",
        required=True
    )
    login_parser.add_argument(
        "--passw",
        help="enter your password",
        required=True
    )

    logout_parser = subparsers.add_parser("logout",
        help="logout",
        parents=[parent_parser])

    sessions_per_point_parser = subparsers.add_parser("SessionsPerPoint",
        help="show selected point's charge sessions for specific interval",
        parents=[parent_parser])
    sessions_per_point_parser.add_argument(
        "--point",
        help="specify point",
        required=True
    )
    sessions_per_point_parser.add_argument(
        "--datefrom",
        help="enter starting date of interval",
        required=True
    )
    sessions_per_point_parser.add_argument(
        "--dateto",
        help="enter ending date of interval",
        required=True
    )

    sessions_per_station_parser = subparsers.add_parser("SessionsPerStation",
        help="show selected station's charge sessions for specific interval",
        parents=[parent_parser])
    sessions_per_station_parser.add_argument(
        "--station",
        help="specify station",
        required=True
    )
    sessions_per_station_parser.add_argument(
        "--datefrom",
        help="enter starting date of interval",
        required=True
    )
    sessions_per_station_parser.add_argument(
        "--dateto",
        help="enter ending date of interval",
        required=True
    )

    sessions_per_ev_parser = subparsers.add_parser("SessionsPerEV",
        help="show EV's charge sessions for specific interval",
        parents=[parent_parser])
    sessions_per_ev_parser.add_argument(
        "--ev",
        help="specify ev",
        required=True
    )
    sessions_per_ev_parser.add_argument(
        "--datefrom",
        help="enter starting date of interval",
        required=True
    )
    sessions_per_ev_parser.add_argument(
        "--dateto",
        help="enter ending date of interval",
        required=True
    )

    admin_parser = subparsers.add_parser("Admin",
        help="perform administrative operations",
        parents=[parent_parser])
    admin_group = admin_parser.add_mutually_exclusive_group(required=True)
    admin_group.add_argument(
        "--usermod",
        help="create user or update its password (--username,--passw required)",
        action="store_true"
    )
    admin_group.add_argument(
        "--users",
        help="show user's status",
        default=None
    )
    admin_group.add_argument(
        "--sessionupd",
        help="upload csv file containing charge sessions (--source required)",
        action="store_true"
    )
    admin_group.add_argument(
        "--healthcheck",
        help="perform system healthcheck",
        action="store_true"
    )
    admin_group.add_argument(
        "--resetsessions",
        help="reset charge sessions",
        action="store_true"
    )
    admin_parser.add_argument(
        "--username",
        help="enter username",
        default=None
    )
    admin_parser.add_argument(
        "--passw",
        help="enter password",
        default=None
    )
    admin_parser.add_argument(
        "--source",
        help="csv filename",
        default=None
    )
 
    args = parser.parse_args()

    print(args)

    if len(sys.argv) == 1:
        parser.print_help(sys.stderr)
        sys.exit(1)
    elif args.command == "Admin" and broken_admin_dependencies(args):
        admin_parser.print_help(sys.stderr)
        sys.exit(1)

    function_caller(args)

if __name__ == "__main__":
    main()
