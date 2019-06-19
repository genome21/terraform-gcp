sleep 25
sudo apt-get -y update
sudo apt-get -y install nginx
echo Hostname: $HOSTNAME > /var/www/html/index.nginx-debian.html