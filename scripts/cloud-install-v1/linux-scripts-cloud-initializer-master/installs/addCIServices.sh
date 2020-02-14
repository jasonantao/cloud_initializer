#! /bin/bash
# SETUP THE REQUIRED ENVIRONMENTTapps
echo addCIServices.sh EXECUTING ./env/setEnv.sh
. ./env/setEnv.sh

# INSTALL JAVA APPS DAEMON TO SERVER
echo addCIServices.sh EXECUTING: "echo y | cp -rf ./installs/CI $ciParentDir"
echo y | cp -rf ./installs/CI $ciParentDir

# CHANGE OWNER AND GROUP of all Files in $ciParentDir to $pkgOwner
echo addCIServices.sh EXECUTING: "chown -R $pkgOwner:$pkgOwner $ciParentDir/CI"
chown -R $pkgOwner:$pkgOwner $ciParentDir/CI
echo EXECUTING: "find $ciParentDir/CI -type f -iname "*.sh" -exec chmod +x {} \;"

find $ciParentDir/CI -type f -iname "*.sh" -exec chmod +x {} \;

# INSTALL HTTP WEB CODE TO SERVER
yum install httpd -y
service httpd start
chkconfig httpd on
echo addCIServices.sh EXECUTING: "echo y | cp -rf ./installs/webapp $HTML_HOME"
echo y | cp -rf ./installs/webapp/* $HTML_HOME
echo EXECUTING: "$HTML_HOME/cloudinitializer/ -type f -iname "*.sh" -exec chmod +x {} \;"

# CHANGE OWNER AND GROUP of all Files in $HTML_HOME to $pkgOwner
echo addCIServices.sh EXECUTING: "chown -R $pkgOwner:$pkgOwner $HTML_HOME/cloudinitializer"
echo addCIServices.sh EXECUTING: "chown -R $pkgOwner:$pkgOwner $HTML_HOME/ci"
echo addCIServices.sh EXECUTING: "chown -R $pkgOwner:$pkgOwner $HTML_HOME/cm"
echo addCIServices.sh EXECUTING: "chown -R $pkgOwner:$pkgOwner $HTML_HOME/index.html"
chown -R $pkgOwner:$pkgOwner $HTML_HOME/cloudinitializer
chown -R $pkgOwner:$pkgOwner $HTML_HOME/ci
chown -R $pkgOwner:$pkgOwner $HTML_HOME/cm
chown -R $pkgOwner:$pkgOwner $HTML_HOME/index.html

# REMOVE OLD CLOUD INITIALIZER DAEMON
echo addCIServices.sh EXECUTING: rm /sbin/$daemon
rm /sbin/$daemon

# CREATE SYMBOLIC LINK FOR APPS SERVICES
echo addCIServices.sh EXECUTING: ln -s  $daemonDir/$daemon /sbin/$app
ln -s  $daemonDir/$daemon /sbin/$app

echo addCIServices.sh EXECUTING: chmod 755 /sbin/$daemon
chmod 755  /sbin/$daemon

echo addCIServices.sh EXECUTING: chmod -R 755 $servicesDir
chmod -R 755 $servicesDir
