# Backend

## Installation (WIP)

1. Install requirements

```
$ sudo apt install postgresql python3 python3-pip
$ pip3 install virtualenv
```

2. Provision PostgreSQL DB

PostgreSQL creates `postgres` superuser during installation, which has root psql
access.

- We connect to PostgreSQL as `postgres` and create `eloncharge` user, tying
superuser capabilities to it (required for Django's smooth operation).
`eloncharge`'s pass will be entered in the subsequent password prompt.

```
$ sudo -u postgres createuser --superuser -P eloncharge
```

- We create a PostgreSQL DB named `eloncharge`.

```
$ sudo -u postgres createdb eloncharge
```

- We grant access to `eloncharge` user.

```
$ sudo -u postgres psql
psql=# grant all privileges on database eloncharge to eloncharge;
```

3. Create & activate virtual environment

```
$ python3 -m venv .venv
$ source .venv/bin/activate
```

4. Install Django and PostgreSQL dependency

```
$ python3 -m pip install Django psycopg2-binary
```

5. Run migrations

```
$ python3 manage.py migrate
```

## Usage (WIP)

- Start Django backend, listening at http://localhost:8000

```
$ python3 manage.py runserver 8000
```
