color="\e[33m"
nocolor="\e[0m"
logfile="/tmp/roboshop.log"
app_path="/app"



nodejs()
{
 echo -e "$color Downloading NodeJs Repo\e[0m"
 curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$logfile
 echo -e "$color Installing Nodejs Server\e$nocolor"
 yum install nodejs -y &>>$logfile
 app_start
 npm install &>>$logfile
 service_start
}

app_start()
{
 echo -e "$color Adding user and location\e$nocolor"
 useradd roboshop &>>$logfile
 mkdir ${app_path} &>>$logfile
 cd ${app_path}
 echo -e "$color Downloading New App content and dependencies\e$nocolor"
 curl -O https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>$logfile
 unzip ${component}.zip &>>$logfile
 rm -rf ${component}.zip 
}

mongo_schema()
{
echo -e "$color Downloading and installing the mongodb schema\e$nocolor"
 cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
 yum install mongodb-org-shell -y &>>$logfile
 mongo --host mongodb-dev.munukutla.online <${app_path}/schema/${component}.js &>>$logfile
 }

 service_start()
 {
   echo -e "$color Creating ${component} service\e$nocolor"
     cp /root/roboshop-shell/${component}.service /etc/systemd/system/${component}.service
    echo -e "$color Enabling and starting the ${component} service\e$nocolor"
    systemctl daemon-reload &>>$logfile
    systemctl enable ${component} &>>$logfile
    systemctl restart ${component}
   }

 maven()
 {
   echo -e "$color Installing maven server$nocolor"
   yum install maven -y &>>$logfile
   app_start
   echo -e "$color Downloading dependencies and building application to ${component} server$nocolor"
   mvn clean package &>>$logfile
   mv target/${component}-1.0.jar ${component}.jar &>>$logfile

   echo -e "$color Downloading and installing the mysql schema$nocolor"
   yum install mysql -y &>>$logfile
   mysql -h mysql-dev.munukutla.online -uroot -pRoboShop@1 </app/schema/${component}.sql &>>$logfile
   service_start
 }

 mysql_schema()
 {
   echo -e "$color Downloading and installing the mysql schema$nocolor"
   yum install mysql -y &>>$logfile
   mysql -h mysql-dev.munukutla.online -uroot -pRoboShop@1 </app/schema/${component}.sql &>>$logfile
 }

 python()
 {
   echo -e "$color Installing python server$nocolor"
   yum install python36 gcc python3-devel -y &>>$logfile
   app_start
   echo -e "$color Downloading Dependencies for python server$nocolor"
   pip3.6 install -r requirements.txt &>>$logfile
   service_start
 }