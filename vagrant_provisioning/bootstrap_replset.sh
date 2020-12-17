#!/bin/bash

echo "[TASK 4] edit conffile"
sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/g' /etc/mongod.conf

cat >> /etc/mongod.conf <<EOF
replication:
   replSetName: "rs0"
EOF

cat /etc/mongod.conf



echo "[TASK 4] start mongod"
systemctl start mongod
systemctl status mongod
