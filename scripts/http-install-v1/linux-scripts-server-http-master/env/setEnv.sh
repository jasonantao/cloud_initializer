#!/bin/bash

# HTTP WEB CONFIGURATION PARAMETERS

bootstrap="webBootstrap.sh"

gitRepo="linux-scripts-http-web.git"

pkg=HTTP_WEB
scriptType="apps"
parentDir="/tmp/scripts/$scriptType/"
installDir="$parentDir/$pkg"

pkgOwner=ec2-user

echo Setting External Args
echo These Arguments Overwrite Default Argument Settings
for arg in "$@"; do
  echo setArgs EXECUTING: export $arg
  export $arg
done
