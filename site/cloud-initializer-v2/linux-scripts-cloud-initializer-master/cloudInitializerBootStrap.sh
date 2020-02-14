#!/bin/bash
bootstrapDir=$PWD
bootstrap=$bootstrapDir/cloudInitializerBootStrap.sh

# Ensure script is running under root
if [ "$EUID" -ne 0 ]
then
   sudo -n true 2/dev/null 2>&1
   passwordRequired=$?

   if [ "$passwordRequired" == "1" ]; then
       echo "Please run as root or under user with sudo access sudo" | tee WP_setup.log
   else
       sudo chmod +x $bootstrap
       sudo $bootstrap
   fi
   return 1
fi

# SETUP ENVIRONMENT AND PARAMETERS
pkg=CI
gitRepo="linux-scripts-cloud-initializer.git"
installDir="/opt/CI/bin/scripts/bash/bootstraps/apps/$pkg"

# OverRide args and set new wit paramaters if presented
echo Setting External Args
echo These Arguments Overwrite Default Argument Settings
for arg in "$@"; do
  echo setArgs EXECUTING: export $arg
  export $arg
done

#INITIAL BASIC TOOLS INSTALL
yum update -y

#INSTALL GIT
yum install git -y

if [ -f ~/.ssh/gitHub.key ]; then
   clone="git clone git@github.com:RMelanson/"
else
   clone="git clone https://github.com/RMelanson/"
fi

# Clone $pkg
echo "BOOTSTRAP EXECUTING:  $clone$gitRepo $installDir" | tee -a WP_setup.log
$clone$gitRepo $installDir

# Setup $pkg
cd $installDir

# MAKE ALL SHELL SCRIPTS EXECUTABLE TO ROOT ONLY
find . -name "*.sh" -exec chmod 700 {} \;

# Setup Project
echo BOOTSTRAP EXECUTING: ./setup.sh $* | tee -a WP_setup.log
./setup.sh $* 2>&1| tee -a WP_setup.log

cd $bootstrapDir
