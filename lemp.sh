sudo ufw allow 'Nginx HTTP'
./init.sh

sudo cp ./files/nginx.conf /etc/nginx/nginx.conf
cmp --silent ./files/nginx.conf /etc/nginx/nginx.conf && echo "nginx.conf copied" || echo "nginx.conf IS NOT COPIED!!!!"


sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install certbot python3-certbot-nginx