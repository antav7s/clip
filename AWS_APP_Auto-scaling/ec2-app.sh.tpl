#!/bin/bash
sudo yum install mysql -y
sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_16.x | sudo -E bash -

sudo yum install -y nodejs
sudo yum install -y git
sleep 30

cd

git clone https://github.com/antav7s/zoyla.git
sleep 30

cd zoyla
npm i
sleep 15

MYSQL_HOST="${local}" MYSQL_USER='admin' MYSQL_PASSWORD='admin123' MYSQL_DATABASE='clip' node node.js
