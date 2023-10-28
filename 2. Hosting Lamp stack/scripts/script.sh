#!/usr/bin/bash

sudo su
#update ec2 instance
dnf update

#install apache
dnf install httpd -y

#start apache
systemctl start httpd
systemctl enable httpd

#install php
dnf install php -y

#install php extensions(according to whatever requires)
dnf install php-{cgi,curl,mbstring,gd,mysqlnd,gettext,json,xml,fpm,intl,zip,pear} -y

#add mysql repo
wget https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm 
ls -lrt

#install mysql8
dnf install mysql80-community-release-el9-1.noarch.rpm -y
dnf repolist enabled | grep "mysql.*-community.*" -y
dnf install mysql-community-server -y

#start mysql
systemctl start mysqld
systemctl enable mysqld

#config php.ini file(according to requirements)
#grep 'memory_limit' /etc/php.ini for testing purpose
#memory_limit = parameter, there are many parameters
#grep command search memory limit in above file and display it

sed -i 's/memory_limit = .*/memory_limit = 256M/' /etc/php.ini
sed -i 's/max_execution_time = .*/max_execution_time = 300/' /etc/php.ini

#enable mod_rewrite AllowOverride All
sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/AllowOverride None/AllowOverride all/' /etc/httpd/conf/httpd.conf
# cat httpd.conf | grep .htaccess
# to check .htaccess is set to All from none

#restart web server to take effect
systemctl restart httpd

#installation and configuration

#upload files from s3
cd /var/www/html
aws s3 cp s3://mylampbucket/website.zip /var/www/html
unzip website.zip
#cp -r Website-main/* /var/www/html/
rm -rf website.zip

#importing files to rds
cd /home/ec2-user/
#download file from s3
aws s3 cp s3://mylampbucket/clientmsdb.sql /home/ec2-user/
#change permission of file
sudo chmod 777 clientmsdb.sql
#import to rds
mysql -h webdb.cej96yu4olcz.us-east-1.rds.amazonaws.com -u admin -p appdb < clientmsdb.sql
#open database
mysql -h webdb.cej96yu4olcz.us-east-1.rds.amazonaws.com -u admin -p appdb

