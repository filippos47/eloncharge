# Backend

## Installation

The below commands have been tested on Ubuntu LTS 18.04.

1. Install requirements

    ```bash
    $ sudo apt install postgresql python3 python3-pip
    $ pip3 install virtualenv
    ```

2. Provision PostgreSQL DB

    PostgreSQL creates `postgres` superuser during installation, which has root
    psql access.

    - We connect to PostgreSQL as `postgres` and create `eloncharge` user, tying
    superuser capabilities to it (required for Django's smooth operation).
    `eloncharge`'s pass will be entered in the subsequent password prompt.

        ```bash
        $ sudo -u postgres createuser --superuser -P eloncharge
        ```

    - We create a PostgreSQL DB named `eloncharge`.

        ```bash
        $ sudo -u postgres createdb eloncharge
        ```

    - We grant access to `eloncharge` user.

        ```bash
        $ sudo -u postgres psql
        psql=# grant all privileges on database eloncharge to eloncharge;
        ```

3. Store password in configuration file
    - Move template configuration

        ```bash
        $ cp backend/settings{_test,}.py
        ```

    - Edit `backend/settings.py` to include the password you specified
      for postgres in the `DATABASES` variable.
    
4. Create & activate virtual environment

    ```bash
    $ python3 -m venv .venv
    $ source .venv/bin/activate
    ```

5. Install requirements

    ```bash
    $ pip3 install -r requirements.txt
    ```

6. Run migrations

    ```bash
    $ python3 manage.py migrate
    ```

7. Populate database (optional)

    ```bash
    $ python3 manage.py populatedb
    ```

## Usage

- Start Django backend, listening at http://localhost:8765

    ```bash
    $ python3 manage.py runserver 8765
    ```
