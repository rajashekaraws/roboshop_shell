COMPONENT=cart
source common.sh

PRINT "Install NodeJS Repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOG
STAT $?

PRINT "Install NodeJS"
yum install nodejs -y &>>$LOG
STAT $?

PRINT "Adding Application User"
useradd roboshop &>>$LOG
STAT $?

PRINT "Downloading App Content"
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>$LOG
STAT $?

PRINT "Remove Previous Versions of App"
cd /home/roboshop &>>$LOG
rm -rf cart &>>$LOG
STAT $?

PRINT "Extracting App Content"
unzip -o /tmp/cart.zip &>>$LOG
STAT $?

mv cart-main cart &>>$LOG
cd cart &>>$LOG

PRINT "Install NodeJS Dependencies for App"
npm install &>>$LOG
STAT $?

PRINT "Configure Endpoints for systemD Configuration"
sed -i -e 's/REDIS_ENDPOINT/redis.rajashekar.online/' -e 's/CATALOGUE_ENDPOINT/catalogue.rajashekar.online/' /home/roboshop/cart/systemd.service &>>$LOG
STAT $?

PRINT "SetUp systemD service"
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service &>>$LOG
STAT $?

PRINT "Reload systemd"
systemctl daemon-reload &>>$LOG
STAT $?

PRINT "Restart Cart"
systemctl restart cart &>>$LOG
STAT $?

PRINT "Enable Cart Service"
systemctl enable cart &>>$LOG
STAT $?