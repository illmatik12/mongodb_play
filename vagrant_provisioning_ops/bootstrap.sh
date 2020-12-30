#!/bin/bash

# Update hosts file
echo "[TASK 0] Update /etc/hosts file"
cat >>/etc/hosts<<EOF
172.17.20.100 opsmongodb0.example.com opsmongodb0 
172.17.20.101 opsmongodb1.example.com opsmongodb1
172.17.20.102 opsmongodb2.example.com opsmongodb2
EOF
