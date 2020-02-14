#! /bin/bash
# Setup the required environment
. ./env/setEnv.sh

#------------------- INITIAL INSTALL --------------------
yum install httpd -y
echo "Server Available" > /var/www/html/index.html
service httpd start
chkconfig httpd on
