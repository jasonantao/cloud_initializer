#!/bin/bash

# BOOTSTRAPS CONFIGURATION PARAMETERS
bootstrap="masterBootstrap.sh"
gitRepo="linux-scripts-bootstraps.git"

#SET UP INSTALLATION DIRECTORY`
pkg=BOOTSTRAPS
scriptType="utils"
parentDir="/tmp/scripts/$scriptType/"
installDir="$parentDir/$pkg"

export BASE_INSTALL=/tmp/scripts
export SW_HOME=/home/SW_HOME
