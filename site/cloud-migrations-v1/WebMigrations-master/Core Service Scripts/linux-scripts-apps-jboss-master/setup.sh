#! /bin/bash
# INSTALL JBOSS ON LINUX WITH REMOTE ACCESS AS A SERVICE

# SETUP WILDFLY CONFIGURATION ENVIRONMENT AND PARAMETERS
. ./env/setEnv.sh

#CHECK IF WILDFLY INSTALLED AND RETURN IF INSTALLED
. ./utils/exitIfInstalled.sh $wfHome

# INSTALL REQUIRED DEVELOPMENT LIBRARIES
./install/installJava8.sh

# SET UP WILDFLY ADMIN USER
./install/addPkgUser.sh $wfOwner $wfGroup $wfHome $pkg

# DOWNLOAD AND INSTALL WILDFLY 10
./install/installjBoss10.sh $wfOwner $wfGroup $wfHome $wfLog

# SET UP WILDFLY REMOTING CONFIGURATION 
./install/configjBossRemoting.sh $wfHome $wfAdmin

# CONFIGURE WILDFLY AS A SERVICE AND START WILDFLY SERVICE
./install/addjBossAsService.sh $wfHome 

# START JBOSS WILDFLY
service wildfly start
