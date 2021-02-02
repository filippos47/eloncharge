test:
	python3 manage.py test

build:
	pip3 install -r requirements.txt
	python3 manage.py migrate
	python3 manage.py populatedb

install:
	nohup python3 manage.py runserver 8765 &
