COMPONENT=frontend
CONTENT="*"
source common.sh

PRINT "Install Nginx"
yum install nginx -y
STAT $?
APP_LOC=/usr/share/nginx/html

DOWNLOAD_APP_CODE

mv frontend-main/static/* .

PRINT "Copy Roboshop Configuration File"
mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf



PRINT "Update RoboShop Configuration"
sed -i -e '/catalogue/ s/localhost/dev-catalogue.rajashekar.online/'  -e '/user/ s/localhost/dev-user.rajashekar.online/' -e '/cart/ s/localhost/dev-cart.rajashekar.online/' -e '/shipping/ s/localhost/dev-shipping.rajashekar.online/' -e '/payment/ s/localhost/dev-payment.rajashekar.online/' /etc/nginx/default.d/roboshop.conf
STAT $?

PRINT "Enable Nginx Service"
systemctl enable nginx &>>$LOG
STAT $?

PRINT "Start Nginx Service"
systemctl restart nginx &>>$LOG
STAT $?