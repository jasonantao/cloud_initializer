#sudo yum localinstall mysql80-community-release-el7-1.noarch.rpm -y
#sudo yum install mysql-community-server -y
#mysql_secure_installation


# First download mySQL for yum repository

wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm
yum update -y

# Finally Install MySQL as usual and start the service.
sudo yum install mysql-server -y
sudo systemctl start mysqld
