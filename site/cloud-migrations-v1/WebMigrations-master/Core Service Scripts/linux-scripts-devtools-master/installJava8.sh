#!/bin/bash
#------------------- DOWNLOAD AND INSTALL JAVA 8 AND MAKE DEFAULT --------------------
yum install java-1.8.0-openjdk-devel -y
echo 2 | /usr/sbin/alternatives --config java
echo 2 | /usr/sbin/alternatives --config javac
echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0" >> /etc/profile.d/java.sh
