echo -e "\e[32m Installing python server\e[0m"
yum install python36 gcc python3-devel -y
echo -e "\e32m Adding user and location\e[0m"
useradd roboshop
mkdir /app
cd /app
rm -rf *
echo -e "\e[32m Downloading new app to shipping server\e[0m"
curl -O https://roboshop-artifacts.s3.amazonaws.com/payment.zip
unzip payment.zip
echo -e "\e[32m Downloading dependencies and building application to shipping server\e[0m"
pip3.6 install -r requirements.txt
echo -e "\e[32m creating shipping service file\e[0m"
cp /root/roboshop-shell/payment.service /etc/systemd/system/payment.service
echo -e "\e[32m Enabling and starting the shipping service\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping