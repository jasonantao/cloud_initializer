# Add Users
bootstrap="addUsersBootstraps.sh"
gitRepo="linux-scripts-utils-add-users"

#SET UP INSTALLATION DIRECTORY`
pkg=ADD_USERS
scriptType="utils"
parentDir="/tmp/scripts/$scriptType/"
installDir="$parentDir/$pkg"

sshDevKey=./keyLocker/developers
USERS=./users/*
KEYS=./keyLocker
SHELL=./shells

pkgOwner=ec2-user

echo Setting External Args
echo These Arguments Overwrite Default Argument Settings
for arg in "$@"; do
  echo setArgs EXECUTING: export $arg
  export $arg
done
