#!/bin/bash
oldrootpass=$(sudo grep 'temporary password' /var/log/mysqld.log | rev | cut -d' ' -f1 | rev)
echo mysqladmin -u root -p "$oldrootpass" password 'admin' 

#/bin/mysql_secure_installation

