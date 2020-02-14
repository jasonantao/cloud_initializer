#! /bin/bash
# INSTALL JENKINS ON LINUX WITH REMOTE ACCESS AS A SERVICE

# SETUP WILDFLY CONFIGURATION ENVIRONMENT AND PARAMETERS
echo "$setupName: EXECUTING: . ./env/setEnv.sh $*"
. ./env/setEnv.sh $*

# COPY RESTORE 
cp $pkg_RESTORE.sh ..

#CHECK IF JENKINS INSTALLED AND RETURN IF INSTALLED
echo Setup.sh:  EXECUTING . ./utils/exitIfInstalled.sh $jenkinsLock
. ./utils/exitIfInstalled.sh $jenkinsLock

#INSTALL JAVA 8
echo Setup.sh:  EXECUTING . ./installs/installJava8.sh
. ./installs/installJava8.sh

# DOWNLOAD AND INSTALL JENKINS 10
echo Setup.sh:  EXECUTING . ./installs/installJenkins.sh
. ./installs/installJenkins.sh

# START JENKINS AS A SERVICE

echo Setup.sh:  EXECUTING . ./installs/addJenkinsService.sh $JENKINS_SERVER
. ./installs/addJenkinsService.sh $JENKINS_SERVER
