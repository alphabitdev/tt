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
	listen [::]:80 ipv6only=on;

	server_name $DOMAIN;

	root /home/$USER/www/$DOMAIN;
	index index.php index.html index.htm;

	location / {
		try_files \$uri \$uri/ =404;
	}
    error_page 404 /404.html;
	error_page 500 502 503 504 /50x.html;
	location = /50x.html {
		root /usr/share/nginx/html;
	}
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.2-fpm.sock;
	}
}" > /etc/nginx/sites-available/"$DOMAIN"
sudo ln -s /etc/nginx/sites-available/"$DOMAIN" /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
sudo certbot --nginx
sudo certbot renew --dry-run