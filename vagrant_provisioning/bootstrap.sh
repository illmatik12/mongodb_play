#!/bin/bash

# Update hosts file
echo "[TASK 0] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.16.20.100 mongodb0.example.com mongodb0 
172.16.20.101 mongodb1.example.com mongodb1
172.16.20.102 mongodb2.example.com mongodb2
EOF


echo "[TASK 1] Update repo file"
touch /etc/yum.repos.d/mongodb-org-4.4.repo
cat >> /etc/yum.repos.d/mongodb-org-4.4.repo <<EOF
[mongodb-org-4.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.4.asc
EOF

cat /etc/yum.repos.d/mongodb-org-4.4.repo 

echo "[TASK 2] Install mongodb"

yum install -y mongodb-org


echo "[TASK 3] create directory"
mkdir -p /var/lib/mongo
mkdir -p /var/log/mongodb

chown -R mongod:mongod /var/lib/mongo 
chown -R mongod:mongod /var/log/mongodb 

