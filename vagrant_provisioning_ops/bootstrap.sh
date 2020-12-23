#!/bin/bash

# Update hosts file
echo "[TASK 0] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.17.20.100 opsmongodb0.example.com opsmongodb0 
172.17.20.101 opsmongodb1.example.com opsmongodb1
172.17.20.102 opsmongodb2.example.com opsmongodb2
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

