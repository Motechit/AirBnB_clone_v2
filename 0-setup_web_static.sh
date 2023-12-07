#!/usr/bin/env bash
# This script sets up my web servers for the deployment of web_static

apt-get -y update > /dev/null
apt-get install -y nginx > /dev/null

# To create all necessary directories and files
mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/
touch /data/web_static/releases/test/index.html
echo "Hello World again!" > /data/web_static/releases/test/index.html

# To check if the directory current exists
if [ -d "/data/web_static/current" ]
then
        sudo rm -rf /data/web_static/current
fi
# To create a symbolic link to test
ln -sf /data/web_static/releases/test/ /data/web_static/current

# To change ownership to the ubuntu user
chown -hR ubuntu:ubuntu /data

# To configure nginx to serve content pointed to by symbolic link to hbnb_static
sed -i '38i\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

# To restart the server
service nginx restart
