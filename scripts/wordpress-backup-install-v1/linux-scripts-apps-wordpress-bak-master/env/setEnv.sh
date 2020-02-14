#!/bin/bash

# WP BACKUP CONFIGURATION PARAMETERS
bootstrap="wpBackupBootstrap.sh"

gitRepo="linux-scripts-apps-wp-backuprestore.git"

#SET UP INSTALLATION DIRECTORY
pkg=WP_BAK
scriptType="utils"
parentDir="/tmp/scripts/$scriptType/"
installDir="$parentDir/$pkg"

pkgOwner=ec2-user

echo Setting External Args
echo These Arguments Overwrite Default Argument Settings
for arg in "$@"; do
  echo setArgs EXECUTING: export $arg
  export $arg
done
