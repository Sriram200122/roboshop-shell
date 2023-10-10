color="\e[32m"
nocolor="\e[0m"
logfile="/tmp/mysql.log"

echo -e "$color Disabiling Mysql default version$nocolor"
yum module disable mysql -y &>>$logfile
echo -e "$color Setting up the MySQL5.7 repo file$nocolor"
cp /root/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "$color Installing mysql server$nocolor"
yum install mysql-community-server -y &>>$logfile
echo -e "$color Changing default root password$nocolor"
mysql_secure_installation --set-root-pass RoboShop@1 &>>$logfile
echo -e "$color Enabling and starting Mysql server$nocolor"
systemctl enable mysqld &>>$logfile
systemctl restart mysqld