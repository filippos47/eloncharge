#!/bin/sh

echo "Prior to executing the following script, please ensure that:"
echo "1. You have set back-end API url properly at:"
echo "   - front-end: \$REACT_ENV_FILE: 'REACT_APP_API_URL' variable"
echo "2. PSQL db pass set inside \$DJANGO_CUSTOM_SETTINGS file is same with actual"
echo "   db password, \$DB_PASS"

while true; do
    read -p "Do you wish to install this program? [y/n]" yn
    case $yn in
        [Yy] ) break;;
        * ) exit;;
    esac
done

DIR=`git rev-parse --show-toplevel`
VENV_FOLDER="$DIR/.venv"
PIP_REQUIREMENTS="$DIR/deployment/requirements.txt"
DB_NAME="eloncharge"
DB_PASS="eloncharge"
DJANGO_CUSTOM_SETTINGS="$DIR/back-end/backend/settings_test.py"
DJANGO_SETTINGS_FILE="$DIR/back-end/backend/settings.py"
REACT_ENV_FILE="$DIR/front-end/.env"
SSL_CONFIGURATION="$DIR/deployment/ssl"
NGINX_SERVER_BLOCKS="$DIR/deployment/nginx/eloncharge"

### BUILD

echo "BUILD PHASE"
echo "##########################"
echo "Installing required packages.."
sudo apt -qq update -y
sudo apt -qq install postgresql python3 python3-pip python3-venv npm gunicorn nginx -y

echo "Setting up virtual environment.."
python3 -m venv $VENV_FOLDER
source $VENV_FOLDER/bin/activate
pip3 install -r $PIP_REQUIREMENTS > /dev/null

echo "Provision PSQL db.."
echo "- Drop previous instances of user/db, if existing"
sudo -u postgres dropdb "$DB_NAME" --if-exists
sudo -u postgres dropuser "$DB_NAME" --if-exists
echo "- Create $DB_NAME user and corresponding db"
sudo -u postgres psql -c "CREATE USER $DB_NAME WITH ENCRYPTED PASSWORD '$DB_PASS' SUPERUSER;" 
sudo -u postgres createdb "$DB_NAME"
echo "- Grant all prigileges for db $DB_NAME to $DB_NAME"
sudo -u postgres psql -c "grant all privileges on database $DB_NAME to $DB_NAME;"

echo "Setting up backend.."
echo "- Import Django settings"
cp $DJANGO_CUSTOM_SETTINGS $DJANGO_SETTINGS_FILE
echo "- Run migrations"
cd $DIR/back-end
python3 manage.py migrate > /dev/null
echo "- Populate db with demo data. Check below for dummy user credentials."
python3 manage.py populatedb-demo

echo "Setting up frontend.."
cd $DIR/front-end
npm install --silent

echo "Setting up cli-client.."
cd $DIR/cli-client
python3 setup.py build > /dev/null
python3 setup.py install > /dev/null

echo "Setting up NGINX reverse proxy.."
echo "- Setting up self-signed TLS"
sudo cp -r $SSL_CONFIGURATION/* /etc/ssl
echo "- Set up NGINX server blocks"
sudo cp $NGINX_SERVER_BLOCKS /etc/nginx/sites-available/eloncharge
sudo ln -sn /etc/nginx/sites-available/eloncharge /etc/nginx/sites-enabled/eloncharge  2>/dev/null
sudo rm /etc/nginx/sites-enabled/default 2>/dev/null
echo "- Consume configuration"
sudo systemctl restart nginx
if ! grep -q "127.0.0.1 eloncharge.gr" /etc/hosts; then
    echo "- One-off cheat to list webpage under eloncharge.gr"
    sudo /bin/sh -c 'echo "127.0.0.1 eloncharge.gr" >> /etc/hosts'
fi

### DEPLOY

echo "DEPLOY PHASE"
echo "##########################"
echo "Fire up React server"
cd $DIR/front-end
nohup npm start &

echo "Fire up Django application through Gunicorn"
cd $DIR/back-end
nohup gunicorn --access-logfile - --workers 10 --bind 127.0.0.1:8000 backend.wsgi &

echo "Deployment was successful! You can now browse the application at" \
     "https://eloncharge.com, enjoy!"
