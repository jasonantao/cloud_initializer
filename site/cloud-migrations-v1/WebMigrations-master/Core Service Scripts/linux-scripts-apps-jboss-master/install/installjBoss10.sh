# WILDFLY INITIAL INSTALLATION SETUP
wfOwner=$1
wfGroup=$2
wfHome=$3
wfLog=$4
wfPkg=wildfly-10.0.0.Final.tar.gz

echo Executing $0 $1 $2 $3 $4

# DOWNLOAD WILDFLY
wget http://download.jboss.org/wildfly/10.0.0.Final/wildfly-10.0.0.Final.tar.gz
echo EXECUTING tar -xzf $wfPkg -C $wfHome --strip 1

# EXTRACT TO HOME DIRECTORY
tar -xzf $wfPkg -C $wfHome --strip 1
echo y | rm $wfPkg 

# CHANGE TO APPROPRIATE OWNER:GROUP
chown -R $wfOwner:$wfGroup $wfHome

mkdir -p $wfLog 
chown -R $wfOwner:$wfGroup $wfLog
