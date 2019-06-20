sleep 25
sudo apt-get -y update
sudo apt-get -y install nginx
export PUBLIC_IPV4=$(curl ifconfig.me) 
echo Hostname: $HOSTNAME and IP Address: $PUBLIC_IPV4 > /var/www/html/index.nginx-debian.html