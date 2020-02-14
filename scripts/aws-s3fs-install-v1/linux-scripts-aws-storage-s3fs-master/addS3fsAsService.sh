#Set s3fs as an init.d service
echo y|cp -rf s3fs.d /etc/init.d/s3fs
echo y|cp -rf s3fsMounts /etc/init.d/s3fsMounts
chkconfig s3fs on
service s3fs start
