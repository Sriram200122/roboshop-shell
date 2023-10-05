echo -e "\e[32m Downloading NodeJs Repo\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo -e "\e[32m Installing Nodejs Server\e[0m"
yum install nodejs -y
echo -e "\e[32m Adding user and location\e[0m"
useradd roboshop
mkdir /app
cd /app
echo -e "\e[32m Downloading New App content and dependencies\e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
unzip catalogue.zip
rm -rf catalogue.zip
npm install
echo -e "\e[32m Creating Catalogue service\e[0m"
cp /root/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service
echo -e "\e[32m Downloading and installing the mongodb schema\e[0m"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo
yum install mongodb-org-shell -y
mongo --host mongodb-dev.munukutla.online </app/schema/catalogue.js
echo -e "\e[32m Enabling and starting the catalogue service\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue
