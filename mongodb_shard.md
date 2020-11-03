# MongoDB Shard using docker containers


# Mongos
- 60000 
- 60001

## ConfigServer 
- Primary : 40001
- Secondary : 40002
- Secondary : 40003

docker-compose -f config-server/docker-compose.yaml up -d


```js
rs.initiate(
  {
    _id: "cfgrs",
    configsvr: true,
    members: [
      { _id : 0, host : "10.210.11.120:40001" },
      { _id : 1, host : "10.210.11.120:40002" },
      { _id : 2, host : "10.210.11.120:40003" }
    ]
  }
)

rs.status()
```

## Shard1 
- Primary : 50001
- Secondary : 50002
- Secondary : 50003


docker-compose -f shard1/docker-compose.yaml up -d

```js
rs.initiate(
  {
    _id: "shard1rs",
    members: [
      { _id : 0, host : "10.210.11.120:50001" },
      { _id : 1, host : "10.210.11.120:50002" },
      { _id : 2, host : "10.210.11.120:50003" }
    ]
  }
)

rs.status()
db.printReplicationInfo()
```

## Mongos
docker-compose -f mongos/docker-compose.yaml up -d

```
sh.addShard("shard1rs/10.210.11.120:50001,10.210.11.120:50002,10.210.11.120:50003")
sh.status()
```

## Adding another shard 

```js
rs.initiate(
  {
    _id: "shard2rs",
    members: [
      { _id : 0, host : "10.210.11.120:50004" },
      { _id : 1, host : "10.210.11.120:50005" },
      { _id : 2, host : "10.210.11.120:50006" }
    ]
  }
)
```

## Add shard to cluster 

connect  mongos 
```
sh.addShard("shard2rs/10.210.11.120:50004,10.210.11.120:50005,10.210.11.120:50006")
```


## Mongodb Sharding
```js
use sharddemo

db.createCollection("movies")
db.createCollection("movies2")

sh.shardCollection("sharddemo.movies2", {"title": "hashed"})

db.movies2.getShardDistribution()

mongos> db.movies2.getShardDistribution()
Collection sharddemo.movies2 is not sharded.
mongos>

for i in {1..50}; do echo -e "use sharddemo \n db.movies2.insertOne({\"title\": \"Spider Man $i\", \"language\" : \"English\"})" | mongo ; done

mongos> use sharddemo
switched to db sharddemo
mongos> db.movies2.find()
{ "_id" : ObjectId("5fa0fe23cb167c27dc0fd5e2"), "title" : "Spider Man 2", "language" : "English" }
{ "_id" : ObjectId("5fa0fe238e501b3380759857"), "title" : "Spider Man 3", "language" : "English" }
{ "_id" : ObjectId("5fa0fe249e2ccd080eda4640"), "title" : "Spider Man 4", "language" : "English" }
{ "_id" : ObjectId("5fa0fe245a89b155290cb6eb"), "title" : "Spider Man 6", "language" : "English" }
{ "_id" : ObjectId("5fa0fe24730e95d8e4e862df"), "title" : "Spider Man 9", "language" : "English" }
{ "_id" : ObjectId("5fa0fe241b0c610ca5e16c6c"), "title" : "Spider Man 10", "language" : "English" }
{ "_id" : ObjectId("5fa0fe24c11e82b9e898ede6"), "title" : "Spider Man 12", "language" : "English" }
{ "_id" : ObjectId("5fa0fe24e8afedc87ed296c1"), "title" : "Spider Man 13", "language" : "English" }
{ "_id" : ObjectId("5fa0fe240192b81db2da8e91"), "title" : "Spider Man 14", "language" : "English" }
{ "_id" : ObjectId("5fa0fe250603565e743f77c9"), "title" : "Spider Man 18", "language" : "English" }
{ "_id" : ObjectId("5fa0fe25bf636636bdf81389"), "title" : "Spider Man 20", "language" : "English" }
{ "_id" : ObjectId("5fa0fe2566e983a59fde414d"), "title" : "Spider Man 22", "language" : "English" }
{ "_id" : ObjectId("5fa0fe2551f755f344fcd924"), "title" : "Spider Man 23", "language" : "English" }
{ "_id" : ObjectId("5fa0fe25ef9eda4a00779c6c"), "title" : "Spider Man 24", "language" : "English" }
{ "_id" : ObjectId("5fa0fe26f2659ab4880e2513"), "title" : "Spider Man 26", "language" : "English" }
{ "_id" : ObjectId("5fa0fe267720cddbab197b60"), "title" : "Spider Man 28", "language" : "English" }
{ "_id" : ObjectId("5fa0fe27d527be070c999639"), "title" : "Spider Man 30", "language" : "English" }
{ "_id" : ObjectId("5fa0fe27eb898efe182739c1"), "title" : "Spider Man 33", "language" : "English" }
{ "_id" : ObjectId("5fa0fe27b2bfbbdaa500074d"), "title" : "Spider Man 35", "language" : "English" }
{ "_id" : ObjectId("5fa0fe27d278101536129984"), "title" : "Spider Man 39", "language" : "English" }
Type "it" for more
mongos>
```


## shard existing collection 
```
db.movies.createIndex( {"title": "hashed"})

sh.shardCollection("sharddemo.movies", {"title": "hashed"} )  

```


### Reference
* https://github.com/justmeandopensource/learn-mongodb