#!/bin/bash
apt-get update -y
apt-get upgrade -y
apt-get install git -y
apt-get install python3 -y
cd /home/ubuntu/
TOKEN='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
git clone https://$TOKEN@github.com/BurakKoban/capstone-project
apt install python3-pip -y
apt-get install python3.7-dev libmysqlclient-dev -y
cd /home/ubuntu/capstone-project/
pip3 install -r requirements.txt
cd /home/ubuntu/capstone-project/src/
python3 manage.py collectstatic --noinput
python3 manage.py makemigrations
python3 manage.py migrate
python3 manage.py runserver 0.0.0.0:80