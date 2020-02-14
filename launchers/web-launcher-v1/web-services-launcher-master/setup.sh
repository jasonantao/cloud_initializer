#! /bin/bash
setupName=setup.sh:
# SETUP THE REQUIRED ENVIRONMENTt
echo setup.sh: EXECUTING: ./env/setEnv.sh
. ./env/setEnv.sh

#INSTALL JAVA 8
echo Setup.sh:  EXECUTING: . ./installs/installJava8.sh
. ./installs/installJava8.sh

# SETUP RECOVERY
echo $setupName EXECUTING: . ./installs/addAppServices.sh
. ./installs/setRecovery.sh

# INSTALL $daemon AS A SERVICE
echo $setupName EXECUTING: . ./installs/addAppServices.sh
. ./installs/addAppServices.sh

#TURN ON $daemon DAEMON
echo $scriptName EXECUTING: chkconfig $daemon on
chkconfig $daemon on
