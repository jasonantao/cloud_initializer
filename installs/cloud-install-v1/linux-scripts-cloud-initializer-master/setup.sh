#! /bin/bash
setupName=setup.sh:

# SETUP THE ENVIRONMENT
echo "$setupName: EXECUTING: . ./env/setEnv.sh $*"
. ./env/setEnv.sh $*

#INSTALL JAVA 8
echo $setupName:  EXECUTING: . ./installs/installJava8.sh
. ./installs/installJava8.sh

# SETUP RECOVERY
echo $setupName EXECUTING: . ./installs/addAppServices.sh
. ./installs/setRecovery.sh

# INSTALL $daemon AS A SERVICE
echo $setupName EXECUTING: . ./installs/addCIServices.sh
. ./installs/addCIServices.sh

#echo $setupName EXECUTING: cp ./cloudInitializerBootStrap.sh ..
#cp ./cloudInitializerBootStrap.sh ..

echo $setupName EXECUTING: cp .uninstalls_CI.sh ../../uninstalls
cp -rf ./installs/uninstall.sh ../../uninstalls/uninstall_$pkg.sh

echo $setupName EXECUTING: cp ./reinstall_CI.sh ../../reinstalls
cp -rf ./installs/reinstall.sh ../../reinstalls/reinstall_$pkg.sh

# START CLOUD_SERVICE SERVICE
echo $setupName EXECUTING: . $ciBashScripts/startCloudInitializerService.sh
. $ciBashScripts/startCloudInitializerService.sh
