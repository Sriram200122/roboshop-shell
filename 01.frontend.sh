source common.sh
component=nginx

echo -e "$color Installing ${component} Server$nocolor"
yum install ${component} -y &>>${logfile}
echo -e "$color Removing default ${component} content$nocolor"
cd /usr/share/${component}/html
rm -rf * &>>${logfile}
echo -e "$color Download New Content to ${component}$nocolor"
curl -O https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>${logfile}
unzip frontend.zip &>>${logfile}
rm -rf frontend.zip
echo -e "$color Configuring reverse proxy server$nocolor"
cp /root/roboshop-shell/roboshop.conf /etc/${component}/default.d/roboshop.conf
echo -e "$color Enabling and starting the ${component} server$nocolor"
systemctl enable ${component} &>>${logfile}
systemctl restart ${component}
