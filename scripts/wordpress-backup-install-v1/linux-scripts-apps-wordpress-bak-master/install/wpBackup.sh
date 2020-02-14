#!/bin/bash

TODAY=`date '+%Y%m%d'`
TEMP_DIR=/var/wpbackup

BACKUP_NAME="wpbackup"
DB_NAME="jason"
DB_USER="jason"
DB_PASS="jason"
SITE_PATH=/var/www/html/wordpress

echo "Backup Now Entering Progress ........................."

mkdir $TEMP_DIR

mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $TEMP_DIR/database.sql

tar --exclude="updraft" -zcf $TEMP_DIR/files.tar.gz $SITE_PATH

tar -zcf $BACKUP_NAME-$TODAY.tar.gz -C $TEMP_DIR .

#rm -Rf $TEMP_DIR

echo "Thank you for using Jason Antao Backup Script Complete [$(du -sh $BACKUP_NAME-$TODAY.tar.gz | awk '{print $1}')]"

