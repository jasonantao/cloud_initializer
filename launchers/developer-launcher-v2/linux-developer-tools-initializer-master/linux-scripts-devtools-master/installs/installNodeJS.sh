#!/bin/bash
#Install nodejs
nodejsPkg=sudo yum install nodejs --enablerepo=epel-testing
wget http://download.fedoraproject.org/pub/epel/6/x86_64/$nodejsPkg
sudo rpm -ivh $nodejsPkg
sudo yum install nodejs --enablerepo=epel-testing
rm $nodejsPkg
