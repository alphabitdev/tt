#! /bin/bash

if [ $# -ne 2 ]
then
    echo "Usage: $(basename $0) DOMAIN"
    exit 1
fi
DOMAIN=$1
USER=$2
sudo echo "server {
	listen 80;
	listen [::]:80;

	server_name $DOMAIN;

	root /home/$USER/www/$DOMAIN;
	index index.html;

	location / {
		try_files \$uri \$uri/ =404;
	}" > /etc/nginx/sites-available/"$DOMAIN"
