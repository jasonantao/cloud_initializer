#! /bin/bash
# Setup the required environment

function addUser() {
   echo "Adding Dev User $1"
   . ./installs/addDevUser.sh $1 developers
}

if [ $# -eq 0 ]
  then
       echo "No user arguments supplied"
  else
       user=$1
       sshDevKey=$2
       addUser $user $sshDevKey
fi

. ./env/setEnv.sh
