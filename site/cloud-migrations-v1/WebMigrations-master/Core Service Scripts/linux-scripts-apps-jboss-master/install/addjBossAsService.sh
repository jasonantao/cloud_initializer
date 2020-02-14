# CONFIGURE JBOSS AS A SERVICE
wfHome=$1

#Copy init scripts
# COPY AND CONFIGURE INIT SERVICE SCRIPTS

echo y | cp $wfHome/docs/contrib/scripts/init.d/wildfly-init-redhat.sh /etc/init.d/wildfly

echo y | rm -f /etc/default/wildfly.conf
cp $wfHome/docs/contrib/scripts/init.d/wildfly.conf /etc/default
sed -i 's/# JAVA_HOME="\/usr\/lib\/jvm\/default-java"/JAVA_HOME=\/usr\/lib\/jvm\/java-1.8.0/g' /etc/default/wildfly.conf
sed -i 's/# JBOSS_HOME/JBOSS_HOME/g' /etc/default/wildfly.conf
sed -i 's/# JBOSS_USER/JBOSS_USER/g' /etc/default/wildfly.conf
sed -i 's/# JBOSS_CONFIG/JBOSS_CONFIG/g' /etc/default/wildfly.conf
sed -i 's/# STARTUP_WAIT/STARTUP_WAIT/g' /etc/default/wildfly.conf
sed -i 's/# SHUTDOWN_WAIT/SHUTDOWN_WAIT/g' /etc/default/wildfly.conf
sed -i 's/# JBOSS_CONSOLE_LOG/JBOSS_CONSOLE_LOG/g' /etc/default/wildfly.conf

# ADD WILDFLY AS A SERVICE AND START WILDFLY SERVICE ---------------

chkconfig --add wildfly
chkconfig wildfly on
