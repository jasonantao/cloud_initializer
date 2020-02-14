#!/bin/bash
# ADD USERS ON LINUX

# SETUP WILDFLY CONFIGURATION ENVIRONMENT AND PARAMETERS
. ./env/setEnv.sh

#PROCESS USERS
for userFile in $USERS
do
  user=$(echo $userFile | rev | cut -d/ -f1 | rev)
  # Add User $user defined in UserFile $userFile
  ./installs/addUser.sh $user
done
