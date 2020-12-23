# Mongodb Test Cluster 

## hosts 
* mongodb0: 172.16.20.100    
* mongodb1: 172.16.20.101
* mongodb2: 172.16.20.102


# change bindip
```
sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/g' /etc/mongod.conf
```

## /etc/mongod.conf

replication:
   replSetName: "rs0"


## initial replicaset

```js
rs.initiate( {
   _id : "rs0",
   members: [
      { _id: 0, host: "172.16.20.100:27017" },
      { _id: 1, host: "172.16.20.101:27017" },
      { _id: 2, host: "172.16.20.102:27017" }
   ]
})

rs.conf()
```

## Test 
```js
use test
db.test.insertOne({"name":"test One"})
db.test.find()
```

## Enable secondary read

```js
rs.secondaryOk()
```

## Using mongo shell

```bash
mongo "mongodb://mongodb0.example.com:27017,mongodb1.example.com:27017,mongodb2.example.com:27017/?replicaSet=rs0"
```

