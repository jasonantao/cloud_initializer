# CONFIGURE JBOSS REMOTE ADMIN ACCESS
wfHome=$1
admUser=$2

# ADD WILDFLY REMOTE ADMIN USER
$wfHome/bin/add-user.sh $admUser admin --silent

# BACKUP ORIGINAL standalone.xml
cp $wfHome/standalone/configuration/standalone.xml $wfHome/standalone/configuration/standalone.xml.BAK

# CONFIGURE THE STANDALONE LOCAL HOSTNAME FOR REMOTE ADMIN
sed -i "s/127.0.0.1/$(hostname -I|sed 's/ //g')/g" $wfHome/standalone/configuration/standalone.xml
