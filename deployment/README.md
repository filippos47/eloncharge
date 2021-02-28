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

## Installation

1. Install both frontend and backend, following the corresponding guides

2. Install additional requirements

    ```bash
    $ sudo apt install gunicorn nginx
    ```

3. Set up TLS

    ```bash
    $ sudo cp ssl/* /etc/ssl
    ```

4. Set up NGINX and consume configuration

    ```bash
    $ sudo cp nginx/eloncharge /etc/nginx/sites-available/eloncharge
    $ sudo ln -s /etc/nginx/sites-available/eloncharge /etc/nginx/sites-enabled/eloncharge
    $ sudo rm /etc/nginx/sites-enabled/default
    $ sudo systemctl restart nginx
    ```

5. One-off cheat to list the webpage under `eloncharge.gr` (PS: Just buy the
goddamn domain :p)

    ```bash
    $ sudo /bin/sh -c 'echo "127.0.0.1 eloncharge.gr" >> /etc/hosts'
    ```

## Deploy

- Fire up NGINX, if not running already

    ```bash
    $ sudo systemctl start nginx
    ```

- Fire up React server

    ```bash
    $ cd /path/to/eloncharge/repo/front-end
    $ nohup npm start &
    ```

- Fire up Django application through Gunicorn

    ```bash
    $ cd /path/to/eloncharge/repo/back-end
    $ nohup gunicorn --access-logfile - --workers 3 --bind 127.0.0.1:8000 backend.wsgi &
    ```

You can now navigate to `https://eloncharge.com`.
