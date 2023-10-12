color="\e[32m"
nocolor="\e[0m"
logfile="/tmp/rabbitmq.log"

echo -e "\e[32m Downloading rabbitmq repo file\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>$logfile
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>$logfile
echo -e "\e[32m Installing Rabbitmq-server\e[0m"
yum install rabbitmq-server -y &>>$logfile
echo -e "\e[32m Enabling and starting the Rabbitmq-server\e[0m"
systemctl enable rabbitmq-server &>>$logfile
systemctl restart rabbitmq-server
echo -e "\e[32m Adding user and setting permissions \e[0m"
rabbitmqctl add_user roboshop roboshop123 &>>$logfile
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$logfile