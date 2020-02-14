#!/bin/bash
#------------------- DOWNLOAD AND INSTALL JAVA 8 AND MAKE DEFAULT --------------------
echo Installing Java 1.8
echo installJava8.sh: EXECUTING yum install java-1.8.0-openjdk-devel -y
yum install java-1.8.0-openjdk-devel -y

echo installJava8.sh: EXECUTING echo 2 "\|" /usr/sbin/alternatives --config java
echo 2 | /usr/sbin/alternatives --config java

echo installJava8.sh: EXECUTING echo 2 "\|" /usr/sbin/alternatives --config javac
echo 2 | /usr/sbin/alternatives --config javac

echo installJava8.sh: EXECUTING "export JAVA_HOME=/usr/lib/jvm/java-1.8.0 >> /etc/profile.d/java.sh"
echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0" >> /etc/profile.d/java.sh

echo Java 1.8 Installed
