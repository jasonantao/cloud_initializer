wfJava=java-1.8.0-openjdk-devel
function isinstalled {
  if yum list installed "$@" >/dev/null 2>&1; then
    true
  else
    false
  fi
}

# DOWNLOAD AND INSTALL JAVA 8 AND MAKE DEFAULT
#./install/installJava8.sh

#check if  java-1.8.0-openjdk-devel is installed
if isinstalled $wfJava
then
   echo Package $wfJava already installed
#   return
else
   yum install $wfJava -y
   echo 2 | /usr/sbin/alternatives --config java
   echo 2 | /usr/sbin/alternatives --config javac
   echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0" >> /etc/profile.d/java.sh
fi
