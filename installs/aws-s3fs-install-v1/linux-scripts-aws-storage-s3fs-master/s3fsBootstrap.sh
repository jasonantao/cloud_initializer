#!/bin/bash
bootstrapDir=$PWD
bootstrap=$bootstrapDir/s3fsBootstrap.sh

# Ensure script is running under root
if [ "$EUID" -ne 0 ]
then
   sudo -n true 2/dev/null 2>&1
   passwordRequired=$?

   if [ "$passwordRequired" == "1" ]; then
       echo "Please run as root or under user with sudo access sudo"
   else
       sudo chmod +x $bootstrap
       sudo $bootstrap
   fi
   return 1
fi

#INITIAL BASIC TOOLS INSTALL
yum update -y

#INSTALL GIT
yum install git -y

# SETUP ENVIRONMENT AND PARAMETERS
pkg=S3FS
gitRepo="linux-aws-scripts-utils-s3fs.git"
installDir="/tmp/scripts/apps/$pkg"

if [ -f ~/.ssh/gitHub.key ]; then
   clone="git clone git@github.com:RMelanson/"
else
   clone="git clone https://github.com/RMelanson/"
fi

# Clone $pkg
echo Executing $clone$gitRepo $installDir
$clone$gitRepo $installDir

# Setup $pkg
cd $installDir
# MAKE ALL SHELL SCRIPTS EXECUTABLE TO ROOT ONLY
find . -name "*.sh" -exec chmod 700 {} \;

# Setup Project
echo "BOOTSTRAP EXECUTING: ./setup.sh $* 2>&1| tee setup.log"
./setup.sh $* 2>&1| tee setup.log

cd $s3fsCurrDir
