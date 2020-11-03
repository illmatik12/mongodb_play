# MongoDB ReplicatSet 

* Primary * 1 
* Secondary * 2 


primary -> secondary (oplog) 


Election for New primary 



## Demo
- mongodb0 :  172.17.0.7 
- mongodb1 : 172.17.0.8
- mongodb2 : 172.17.0.9

```
docker run -d -p 27017:27017 -v data:/data/db mongo:3.4 --replSet "rs0"
docker run -d -p 27018:27017 -v data:/data/db mongo:3.4 --replSet "rs0"
docker run -d -p 27019:27017 -v data:/data/db mongo:3.4 --replSet "rs0"
```

### ReplicaSet initiate
```js
rs.initiate( {
   _id : "rs0",
   members: [
      { _id: 0, host: "172.17.0.7:27017" },
      { _id: 1, host: "172.17.0.7:27018" },
      { _id: 2, host: "172.17.0.7:27019" }
   ]
})
```


```js
rs0:PRIMARY> rs.status()
{
        "set" : "rs0",
        "date" : ISODate("2020-11-03T04:59:34.798Z"),
        "myState" : 1,
        "term" : NumberLong(1),
        "syncingTo" : "",
        "syncSourceHost" : "",
        "syncSourceId" : -1,
        "heartbeatIntervalMillis" : NumberLong(2000),
        "optimes" : {
                "lastCommittedOpTime" : {
                        "ts" : Timestamp(1604379568, 1),
                        "t" : NumberLong(1)
                },
                "appliedOpTime" : {
                        "ts" : Timestamp(1604379568, 1),
                        "t" : NumberLong(1)
                },
                "durableOpTime" : {
                        "ts" : Timestamp(1604379568, 1),
                        "t" : NumberLong(1)
                }
        },
        "members" : [
                {
                        "_id" : 0,
                        "name" : "172.17.0.7:27017",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 437,
                        "optime" : {
                                "ts" : Timestamp(1604379568, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1604379568, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2020-11-03T04:59:28Z"),
                        "optimeDurableDate" : ISODate("2020-11-03T04:59:28Z"),
                        "lastHeartbeat" : ISODate("2020-11-03T04:59:33.681Z"),
                        "lastHeartbeatRecv" : ISODate("2020-11-03T04:59:34.239Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncingTo" : "172.17.0.8:27017",
                        "syncSourceHost" : "172.17.0.8:27017",
                        "syncSourceId" : 1,
                        "infoMessage" : "",
                        "configVersion" : 1
                },
                {
                        "_id" : 1,
                        "name" : "172.17.0.8:27017",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "uptime" : 1005,
                        "optime" : {
                                "ts" : Timestamp(1604379568, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2020-11-03T04:59:28Z"),
                        "syncingTo" : "",
                        "syncSourceHost" : "",
                        "syncSourceId" : -1,
                        "infoMessage" : "",
                        "electionTime" : Timestamp(1604379147, 1),
                        "electionDate" : ISODate("2020-11-03T04:52:27Z"),
                        "configVersion" : 1,
                        "self" : true,
                        "lastHeartbeatMessage" : ""
                },
                {
                        "_id" : 2,
                        "name" : "172.17.0.9:27017",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 437,
                        "optime" : {
                                "ts" : Timestamp(1604379568, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1604379568, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2020-11-03T04:59:28Z"),
                        "optimeDurableDate" : ISODate("2020-11-03T04:59:28Z"),
                        "lastHeartbeat" : ISODate("2020-11-03T04:59:33.681Z"),
                        "lastHeartbeatRecv" : ISODate("2020-11-03T04:59:34.226Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncingTo" : "172.17.0.8:27017",
                        "syncSourceHost" : "172.17.0.8:27017",
                        "syncSourceId" : 1,
                        "infoMessage" : "",
                        "configVersion" : 1
                }
        ],
        "ok" : 1
}
rs0:PRIMARY> rs.status()
{
        "set" : "rs0",
        "date" : ISODate("2020-11-03T04:59:37.531Z"),
        "myState" : 1,
        "term" : NumberLong(1),
        "syncingTo" : "",
        "syncSourceHost" : "",
        "syncSourceId" : -1,
        "heartbeatIntervalMillis" : NumberLong(2000),
        "optimes" : {
                "lastCommittedOpTime" : {
                        "ts" : Timestamp(1604379568, 1),
                        "t" : NumberLong(1)
                },
                "appliedOpTime" : {
                        "ts" : Timestamp(1604379568, 1),
                        "t" : NumberLong(1)
                },
                "durableOpTime" : {
                        "ts" : Timestamp(1604379568, 1),
                        "t" : NumberLong(1)
                }
        },
        "members" : [
                {
                        "_id" : 0,
                        "name" : "172.17.0.7:27017",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 440,
                        "optime" : {
                                "ts" : Timestamp(1604379568, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1604379568, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2020-11-03T04:59:28Z"),
                        "optimeDurableDate" : ISODate("2020-11-03T04:59:28Z"),
                        "lastHeartbeat" : ISODate("2020-11-03T04:59:35.682Z"),
                        "lastHeartbeatRecv" : ISODate("2020-11-03T04:59:36.240Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncingTo" : "172.17.0.8:27017",
                        "syncSourceHost" : "172.17.0.8:27017",
                        "syncSourceId" : 1,
                        "infoMessage" : "",
                        "configVersion" : 1
                },
                {
                        "_id" : 1,
                        "name" : "172.17.0.8:27017",
                        "health" : 1,
                        "state" : 1,
                        "stateStr" : "PRIMARY",
                        "uptime" : 1008,
                        "optime" : {
                                "ts" : Timestamp(1604379568, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2020-11-03T04:59:28Z"),
                        "syncingTo" : "",
                        "syncSourceHost" : "",
                        "syncSourceId" : -1,
                        "infoMessage" : "",
                        "electionTime" : Timestamp(1604379147, 1),
                        "electionDate" : ISODate("2020-11-03T04:52:27Z"),
                        "configVersion" : 1,
                        "self" : true,
                        "lastHeartbeatMessage" : ""
                },
                {
                        "_id" : 2,
                        "name" : "172.17.0.9:27017",
                        "health" : 1,
                        "state" : 2,
                        "stateStr" : "SECONDARY",
                        "uptime" : 440,
                        "optime" : {
                                "ts" : Timestamp(1604379568, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDurable" : {
                                "ts" : Timestamp(1604379568, 1),
                                "t" : NumberLong(1)
                        },
                        "optimeDate" : ISODate("2020-11-03T04:59:28Z"),
                        "optimeDurableDate" : ISODate("2020-11-03T04:59:28Z"),
                        "lastHeartbeat" : ISODate("2020-11-03T04:59:35.682Z"),
                        "lastHeartbeatRecv" : ISODate("2020-11-03T04:59:36.226Z"),
                        "pingMs" : NumberLong(0),
                        "lastHeartbeatMessage" : "",
                        "syncingTo" : "172.17.0.8:27017",
                        "syncSourceHost" : "172.17.0.8:27017",
                        "syncSourceId" : 1,
                        "infoMessage" : "",
                        "configVersion" : 1
                }
        ],
        "ok" : 1
}
rs0:PRIMARY> rs.printReplicationInfo()
configured oplog size:   1641.8828125MB
log length start to end: 572secs (0.16hrs)
oplog first event time:  Tue Nov 03 2020 04:52:16 GMT+0000 (UTC)
oplog last event time:   Tue Nov 03 2020 05:01:48 GMT+0000 (UTC)
now:                     Tue Nov 03 2020 05:01:52 GMT+0000 (UTC)
rs0:PRIMARY> db.getReplicationInfo()
{
        "logSizeMB" : 1641.8828125,
        "usedMB" : 0.01,
        "timeDiff" : 602,
        "timeDiffHours" : 0.17,
        "tFirst" : "Tue Nov 03 2020 04:52:16 GMT+0000 (UTC)",
        "tLast" : "Tue Nov 03 2020 05:02:18 GMT+0000 (UTC)",
        "now" : "Tue Nov 03 2020 05:02:23 GMT+0000 (UTC)"
}
rs0:PRIMARY>     

rs0:PRIMARY> rs.conf()
{
        "_id" : "rs0",
        "version" : 1,
        "protocolVersion" : NumberLong(1),
        "members" : [
                {
                        "_id" : 0,
                        "host" : "172.17.0.7:27017",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 1,
                        "host" : "172.17.0.8:27017",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                },
                {
                        "_id" : 2,
                        "host" : "172.17.0.9:27017",
                        "arbiterOnly" : false,
                        "buildIndexes" : true,
                        "hidden" : false,
                        "priority" : 1,
                        "tags" : {

                        },
                        "slaveDelay" : NumberLong(0),
                        "votes" : 1
                }
        ],
        "settings" : {
                "chainingAllowed" : true,
                "heartbeatIntervalMillis" : 2000,
                "heartbeatTimeoutSecs" : 10,
                "electionTimeoutMillis" : 10000,
                "catchUpTimeoutMillis" : 60000,
                "getLastErrorModes" : {

                },
                "getLastErrorDefaults" : {
                        "w" : 1,
                        "wtimeout" : 0
                },
                "replicaSetId" : ObjectId("5fa0e200858126f5b6002ef1")
        }
}
rs0:PRIMARY>

rs0:PRIMARY> db.createCollection("helloworld")
{ "ok" : 1 }
rs0:PRIMARY> show collections
helloworld
rs0:PRIMARY>
```

## Secondary 
```
rs.slaveOk()

rs0:SECONDARY> db.createCollection("test")
{
        "ok" : 0,
        "errmsg" : "not master",
        "code" : 10107,
        "codeName" : "NotMaster"
}
rs0:SECONDARY>
```

### Connect ReplicaSet Primary
```
mongo mongodb://172.17.0.7:27017,172.17.0.8:27017,172.17.0.9:27017/?replicaSet=rs0
```
### Connect ReplicaSet Secondary read (동작안함)
```
mongo mongodb://172.17.0.7:27017,172.17.0.8:27017,172.17.0.9:27017/?replicaSet=rs0&readPreference=secondary
```