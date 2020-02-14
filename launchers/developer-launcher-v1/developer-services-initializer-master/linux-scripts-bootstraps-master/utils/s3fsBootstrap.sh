#!/bin/bash

# Ensure script is running under root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root or under sudo"
  exit -1
fi

s3fsCurrDir=$PWD
baseDir=/tmp/scripts
subDir=utils
pkg=S3FS
installDir="$baseDir/$subDir/$pkg"
gitRepo="linux-aws-scripts-utils-s3fs.git"

#INITIAL BASIC TOOLS INSTALL
yum update -y

#INSTALL GIT
yum install git -y

if [ -z "$1" ]; then
   branch=master
else
   branch=$1
fi

#Set Cloning Properties
if [ -f ~/.ssh/gitHub.key ]; then
   clone="git clone -b $branch git@github.com:RMelanson/"
else
   clone="git clone -b $branch https://github.com/RMelanson/"
fi

# Clone $pkg
echo Executing $clone$gitRepo $installDir
$clone$gitRepo $installDir

# Setup $pkg
cd $installDir
. ./setup.sh

cd $s3fsCurrDir
