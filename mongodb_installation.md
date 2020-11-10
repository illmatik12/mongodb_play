# Mongodb Installation

# Configure system

## disable zone_reclaim_mode
```
echo 0 | sudo tee /proc/sys/vm/zone_reclaim_mode
sudo sysctl -w vm.zone_reclaim_mode=0

```
## System C Library 
```
sudo yum update glibc
```
## Set vm.swapiness 1 or 0 
```
vm.swapiness=1
```

## kernel parameter 
```
fs.file-max value of 98000,
kernel.pid_max value of 64000,
kernel.threads-max value of 64000, and
vm.max_map_count value of 128000
```

## Recommended Ulimit Setting
```
-f (file size): unlimited
-t (cpu time): unlimited
-v (virtual memory): unlimited [1]
-l (locked-in-memory size): unlimited
-n (open files): 64000
-m (memory size): unlimited [1] [2]
-u (processes/threads): 64000

```


## Enable ntp time synchronization

## Disable Transparent Huge Pages 
```
/sys/kernel/mm/redhat_transparent_hugepage/enabled
```

## Filesystem 
- XFS or EXT4, XFS stronly recommended 
- set noatime mount point 

## Hardware 
- Use Raid10 and SSD 
- avoid placing same SAN 


## MongoDB Configuration
* /etc/mongod.conf
```yaml
# mongod.conf

# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/

# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log

# Where and how to store data.
storage:
  dbPath: /var/lib/mongo
  journal:
    enabled: true
#  engine:
#  wiredTiger:

# how the process runs
processManagement:
  fork: true  # fork and run in background
  pidFilePath: /var/run/mongodb/mongod.pid  # location of pidfile
  timeZoneInfo: /usr/share/zoneinfo

# network interfaces
net:
  port: 27017
  bindIp: 127.0.0.1  # Enter 0.0.0.0,:: to bind to all IPv4 and IPv6 addresses or, alternatively, use the net.bindIpAll setting.


#security:

#operationProfiling:

replication:
   replSetName: set0

#sharding:
# config server
sharding:
    clusterRole: configsvr
 net:
    bindIp: 10.8.0.12
    port: 27001
replication:
    replSetName: csRS

# shard server
sharding:
   clusterRole: shardsvr
replication:
   replSetName: shardA

## Enterprise-Only Options

#auditLog:

#snmp:
```

## Single
https://docs.mongodb.com/manual/tutorial/install-mongodb-on-red-hat/

## Replication

## Shard 

