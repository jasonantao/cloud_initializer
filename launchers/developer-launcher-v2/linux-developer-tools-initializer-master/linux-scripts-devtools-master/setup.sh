#! /bin/bash
# Setup the required environment
. ./env/setEnv.sh

# COPY RESTORE 
cp $pkg_RESTORE.sh ..

./installs/installGenDevTools.sh
./installs/installSvnRepository.sh
./installs/installGitRepository.sh
./installs/installNodeJS.sh
./installs/installJava8.sh
./installs/installMaven.sh
