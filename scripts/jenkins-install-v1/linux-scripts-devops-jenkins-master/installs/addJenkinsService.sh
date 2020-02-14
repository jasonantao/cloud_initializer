server=$1

# SERVERS AVAILABLE STAND_ALONE, TOMCAT, JBOSS, WEBSPHERE, WEBLOGIC
case "$server" in
   STAND_ALONE)
        echo STARTING JENKINS AS A SERVICE
        echo Setup.sh:  EXECUTING service jenkins start
        service jenkins start
   ;;
   TOMCAT)
        echo $server not yet implemented 
   ;;
   sshPubKey)
        echo $server not yet implemented 
   ;;
   JBOSS)
        echo INSTALLING JBOSS SERVER 
        ./installs/jbossbootstrap.sh
        JBOSS_DEPLOYMENT_DIR=/opt/wildfly/standalone/deployments
        echo EXECUTING DEPLOYMENT: cp $JENKINS_WAR $JBOSS_DEPLOYMENT_DIR
        cp $JENKINS_WAR $JBOSS_DEPLOYMENT_DIR
   ;;
   WEBLOGIC)
        echo $server not yet implemented 
   ;;
   *) echo ERROR: Unknown Server = $server
        exit 1
   ;;
esac


