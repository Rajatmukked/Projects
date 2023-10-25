application framework
vpc 10.0.0.0/16
subnet 10.0.0.0/24
security group - 
server sg= inbound ssh 22, http ,https,mysql,php, outbpund= all
rds sg = inbound mysql source server sg
ec2
rds

software installation
apache
php v8
php extensions 
mysql
php_curl module enable
configure php.ini 
    memory limit =128M
    max execution time = 300
enable mod rewrite module in apache

app configure
store codes in S3
migrate sql script to rds database
copy code from s3 to /var/www/html
set permision 777 for /var/www/html and storage/directory
edit .env in html directory
    app_url = your domain name
    db_host = rds endpoint
    db_databasse = rds name
    db_username = rds db_username
    db_password = rds db_password
add AppServiceProvider.php in /var/www/html/app/Providers
add following code in public fuction boot(): void
if (env('APP_ENV') === 'production') {\Illuminate\Support\Facades\URL::forceScheme('https');}