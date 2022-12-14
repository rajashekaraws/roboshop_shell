source common.sh

PRINT "Install NodeJS Repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
STAT $?

PRINT "Install NodeJS"
yum install nodejs -y
STAT $?

PRINT "Adding Application User"
useradd roboshop
STAT $?

PRINT "Downloading App Content"
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"
STAT $?

PRINT "Remove Previous Versions of App"
cd /home/roboshop
rm -rf cart
STAT $?

PRINT "Extracting App Content"
unzip -o /tmp/cart.zip
STAT $?

mv cart-main cart
cd cart

PRINT "Install NodeJS Dependencies for App"
npm install
STAT $?

PRINT "Configure Endpoints for systemD Configuration"
sed -i -e 's/REDIS_ENDPOINT/redis.rajashekar.online/' -e 's/CATALOGUE_ENDPOINT/catalogue.rajashekar.online/' /home/roboshop/cart/systemd.service
STAT $?

PRINT "SetUp systemD service"
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
STAT $?

PRINT "Reload systemd"
systemctl daemon-reload
STAT $?

PRINT "Restart Cart"
systemctl restart cart
STAT $?

PRINT "Enable Cart Service"
systemctl enable cart
STAT $?