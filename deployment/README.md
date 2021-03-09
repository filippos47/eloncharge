# Production deployment

## Design

In order to simulate a production-like deployment, the following components must
be set in motion:

### Backend

We opt out to deploy our Django application using Gunicorn, a WSGI server which
handles incoming API requests. It is selected as a more robust and scalable
alternative to the bare Django development server.

### Frontend

We set up an NGINX server to act as a reverse proxy in front of our React
application. TLS is also supported through a self-signed certificate, and
TLS termination is handled by NGINX.

### CLI

A cli-client will also be installed, providing extensive operational
capabilities through our API.

## Automation

We have fully automated the installation and deployment process our product,
through the execution of a simple bash script (`fireitup.sh`). Before executing
the script, the following env vars should be reviewed:

```bash
# Name of both the database and its owner.
DB_NAME="eloncharge"

# Password of the database (obviously not secure, but this is just a simulation).
DB_PASS="eloncharge"

# Path to custom Django settings. In case of edit, keep in mind that database
# password must be the same as $DB_PASS!
DJANGO_CUSTOM_SETTINGS="$DIR/back-end/backend/settings_test.py"

# Path to React env variables.
REACT_ENV_FILE="$DIR/front-end/.env"
```

Upon review, just execute the deployment script:
```bash
bash deploy.sh
```

One last step to use the cli-client, is to activate the virtual environment in
which the script installed it. To do so, execute:
```bash
source `git rev-parse --show-toplevel`/.venv/bin/activate`
```

You can now navigate to `https://eloncharge.gr`. You can also administer the app
through our cli-client (try typing `ev_group53 --help` in your terminal).
Have fun!

## Installation & Deployment by hand

In case you want to have full control of the whole process, every required step
is documented below.

### Installation

1. Install requirements

    ```bash
    $ sudo apt update
    $ sudo apt install postgresql python3 python3-pip python3-venv npm gunicorn nginx
    ```

2. Set up virtual environment

    ```bash
    $ cd `git rev-parse --show-toplevel`
    $ python3 -m venv .venv
    $ source .venv/bin/activate
    $ pip3 install -r deployment/requirements.txt
    ```

3. Provision PSQL DB

    ```bash
    $ sudo -u postgres psql -c "CREATE USER eloncharge WITH ENCRYPTED PASSWORD eloncharge SUPERUSER;"
    $ sudo -u postgres createdb eloncharge
    $ sudo -u postgres psql -c "grant all privileges on database eloncharge to eloncharge;"
    ```

4. Set up backend

    ```bash
    $ cd `git rev-parse --show-toplevel`/back-end
    $ cp backend/settings_test.py backend/settings.py
    $ python3 manage.py migrate
    $ python3 manage.py populatedb-demo
    ```
5. Set up frontend

    ```bash
    $ cd `git rev-parse --show-toplevel`/front-end
    $ npm install
    ```

6. Set up cli-client

    ```bash
    $ cd `git rev-parse --show-toplevel`/cli-client
    $ python3 setup.py build
    $ python3 setup.py install
    ```

7. Set up NGINX reverse proxy

    ```bash
    $ cd `git rev-parse --show-toplevel`/deployment
    $ sudo cp -r ssl/* /etc/ssl
    $ sudo cp nginx/eloncharge /etc/nginx/sites-available/eloncharge
    $ sudo ln -sn /etc/nginx/sites-available/eloncharge /etc/nginx/sites-enabled/eloncharge
    $ sudo rm /etc/nginx/sites-enabled/default
    $ sudo systemctl restart nginx
    ```

8. One-off cheat to list webpage under eloncharge.gr

    ```bash
    $ sudo /bin/sh -c 'echo "127.0.0.1 eloncharge.gr" >> /etc/hosts'
    ```

### Deploy

1. Fire up React server

    ```bash
    $ cd `git rev-parse --show-toplevel`/front-end
    $ nohup npm start &
    ```

2. Fire up Django application through Gunicorn

    ```bash
    $ cd `git rev-parse --show-toplevel`/back-end
    $ nohup gunicorn --access-logfile - --workers 3 --bind 127.0.0.1:8000 backend.wsgi &
    ```
