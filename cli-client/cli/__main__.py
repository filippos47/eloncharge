import argparse
import sys

from cli.utils.parsing import (
        method_caller,
        broken_admin_dependencies,
        apikey_present_if_required,
)

def main():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(help="Available functionalities",
        dest="command")

    format_parser = argparse.ArgumentParser(add_help=False)
    format_parser.add_argument(
        "--format",
        help="select desired output format (supported: csv, json)",
        choices=["csv", "json"],
        required=True
    )

    apikey_parser = argparse.ArgumentParser(add_help=False)
    apikey_parser.add_argument(
        "--apikey",
        help="provide API token (or populate ~/softeng20bAPI.token)",
        default=None
    )

    healthcheck_parser = subparsers.add_parser("healthcheck",
        help="perform system healthcheck")

    resetsessions_parser = subparsers.add_parser("resetsessions",
        help="reset charge sessions")

    login_parser = subparsers.add_parser("login",
        help="login using your credentials")
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
        parents=[apikey_parser])

    sessions_per_point_parser = subparsers.add_parser("SessionsPerPoint",
        help="show selected point's charge sessions for specific interval",
        parents=[format_parser, apikey_parser])
    sessions_per_point_parser.add_argument(
        "--point",
        help="specify point [<ID>]",
        required=True
    )
    sessions_per_point_parser.add_argument(
        "--datefrom",
        help="enter starting date of interval [YYYY-MM-DD hh:mm:ss]",
        required=True
    )
    sessions_per_point_parser.add_argument(
        "--dateto",
        help="enter ending date of interval [YYYY-MM-DD hh:mm:ss]",
        required=True
    )

    sessions_per_station_parser = subparsers.add_parser("SessionsPerStation",
        help="show selected station's charge sessions for specific interval",
        parents=[format_parser, apikey_parser])
    sessions_per_station_parser.add_argument(
        "--station",
        help="specify station [<ID>]",
        required=True
    )
    sessions_per_station_parser.add_argument(
        "--datefrom",
        help="enter starting date of interval [YYYY-MM-DD hh:mm:ss]",
        required=True
    )
    sessions_per_station_parser.add_argument(
        "--dateto",
        help="enter ending date of interval [YYYY-MM-DD hh:mm:ss]",
        required=True
    )

    sessions_per_ev_parser = subparsers.add_parser("SessionsPerEV",
        help="show EV's charge sessions for specific interval",
        parents=[format_parser, apikey_parser])
    sessions_per_ev_parser.add_argument(
        "--ev",
        help="specify ev [<LICENSE-PLATE>]",
        required=True
    )
    sessions_per_ev_parser.add_argument(
        "--datefrom",
        help="enter starting date of interval [YYYY-MM-DD hh:mm:ss]",
        required=True
    )
    sessions_per_ev_parser.add_argument(
        "--dateto",
        help="enter ending date of interval [YYYY-MM-DD hh:mm:ss]",
        required=True
    )

    admin_parser = subparsers.add_parser("Admin",
        help="perform administrative operations",
        parents=[format_parser, apikey_parser])
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
        help="enter username (alphanumeric latin characters only)",
        default=None
    )
    admin_parser.add_argument(
        "--passw",
        help="enter password (must not be an empty string)",
        default=None
    )
    admin_parser.add_argument(
        "--source",
        help="csv filename",
        default=None
    )

    args = parser.parse_args()
    PARSER_MAP = {"logout": logout_parser,
              'SessionsPerPoint': sessions_per_point_parser,
              'SessionsPerStation': sessions_per_station_parser,
              'SessionsPerEV': sessions_per_ev_parser,
              'Admin': admin_parser}

    if len(sys.argv) == 1:
        parser.print_help(sys.stderr)
        sys.exit(1)
    elif args.command == "Admin" and broken_admin_dependencies(args):
        admin_parser.print_help(sys.stderr)
        sys.exit(1)
    elif not apikey_present_if_required(args):
        parser_scope = PARSER_MAP[args.command]
        parser_scope.print_help(sys.stderr)
        sys.exit(1)

    print(method_caller(args))

if __name__ == "__main__":
    main()
