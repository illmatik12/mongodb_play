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


echo "[TASK 2] Update limit conf file"

cat >> /etc/security/limits.conf << EOF

#mongodb opsmanager
mongod          hard      nproc 64000 
mongod          soft      nproc 64000 
mongod          hard      nofile 64000 
mongod          soft      nofile 64000 

mongodb-mms     hard      nproc 64000 
mongodb-mms     soft      nproc 64000 
mongodb-mms     hard      nofile 64000 
mongodb-mms     soft      nofile 64000 
EOF

echo "[TASK 2] Install mongodb"

yum install -y mongodb-org wget net-tools


echo "[TASK 3] create directory"
mkdir -p /var/lib/mongo
mkdir -p /var/log/mongodb

chown -R mongod:mongod /var/lib/mongo 
chown -R mongod:mongod /var/log/mongodb 


echo "[TASK 4] update mongod conf "
rm /etc/mongod.conf
cat >> /etc/mongod.conf << EOF
systemLog:
  destination: file

  path: "/var/log/mongodb/mongodb.log"

  logAppend: true
storage:

  dbPath: "/var/lib/mongo"

  journal:
    enabled: true

  wiredTiger:

    engineConfig:

      cacheSizeGB: 1

processManagement:
  fork: true
  timeZoneInfo: /usr/share/zoneinfo
  pidFilePath: /var/run/mongodb/mongod.pid
net:
  bindIp: 127.0.0.1
  port: 27017

setParameter:

  enableLocalhostAuthBypass: false
EOF

echo "[TASK 5] start mongod"
systemctl start mongod 

echo "[TASK 6] install mongodb-mms"
wget -nv -P /tmp/ https://downloads.mongodb.com/on-prem-mms/rpm/mongodb-mms-4.4.6.100.20201201T2030Z-1.x86_64.rpm
sudo rpm -ivh /tmp/mongodb-mms-4.4.6.100.20201201T2030Z-1.x86_64.rpm
systemctl start mongodb-mms

