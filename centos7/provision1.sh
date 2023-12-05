#!/usr/bin/env bash

#Install Apache web server
sudo apt install -y httpd

#Start Apache and set ir to run at boot
sudo systemclt start httpd
sudo systemclt enable httpd

#Create a sample index.html file
sudo echo "<html><body><h1>Escrevi e sai correndo, pau no cu de quem tá lendo!</h1></body></html>" > /var/www/html/index.html

#Restart Apache to serve the new index.html file
sudo systemclt restart httpd