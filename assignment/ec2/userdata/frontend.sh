#! /bin/bash

sudo yum update -y
sudo yum install curl -y 
sudo yum install httpd -y 
sudo yum install mod_ssl -y
sudo sed -i 's/Listen/#Listen/g' /etc/httpd/conf/httpd.conf
sudo systemctl restart httpd