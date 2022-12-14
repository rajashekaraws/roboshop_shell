curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
dnf module disable mysql

yum install mysql-community-server -y

systemctl enable mysqld
systemctl restart mysqld

echo "ALTER USER 'root@localhost' IDENTIFIED BY 'RoboShop@1';" > /tmp/root-pass-sql

cat /tmp/root-pass-sql | mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}"