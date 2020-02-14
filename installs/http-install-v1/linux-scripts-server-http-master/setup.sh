#! /bin/bash
setupName=setup.sh:

# SETUP THE ENVIRONMENT
echo "$setupName: EXECUTING: . ./env/setEnv.sh $*"
. ./env/setEnv.sh $*

# COPY RESTORE 
cp $pkg_RESTORE.sh ..

#------------------- INITIAL INSTALL --------------------
yum install httpd -y
echo "Server Available" > /var/www/html/index.html
service httpd start
chkconfig httpd on
