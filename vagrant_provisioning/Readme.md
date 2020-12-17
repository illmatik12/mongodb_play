# Mongodb Test Cluster 

## hosts 
mongo1
mongo2
mongo3


sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/g' /etc/mongod.conf
bindIp: 127.0.0.1



## /etc/mongod.conf

replication:
   replSetName: "rs0"


## initial replicaset
rs.initiate( {
   _id : "rs0",
   members: [
      { _id: 0, host: "172.16.20.100:27017" },
      { _id: 1, host: "172.16.20.101:27017" },
      { _id: 2, host: "172.16.20.102:27017" }
   ]
})

rs.conf()

## Test 
'''
use test
db.test.insertOne({"name":"test One"})
db.test.find()
'''