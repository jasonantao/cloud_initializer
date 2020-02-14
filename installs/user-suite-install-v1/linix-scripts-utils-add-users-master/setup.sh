#! /bin/bash
# SETUP THE ENVIRONMENT
setupName=setup.sh
echo "$setupName: EXECUTING: . ./env/setEnv.sh $*"
. ./env/setEnv.sh $*

# COPY RESTORE 
cp $pkg_RESTORE.sh ..

#------------------- INITIAL INSTALL --------------------
./installs/addUsers.sh
