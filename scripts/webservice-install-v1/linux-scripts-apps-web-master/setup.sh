#!/bin/bash

#------------------- INITIAL INSTALL --------------------
yum install httpd -y
echo "Server Available" > /var/www/html/index.html
service httpd start
chkconfig httpd on
