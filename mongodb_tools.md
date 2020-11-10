# Mongodb Tools
## mongodb 

```
[root@f3d7ecd9cb6a ~]# mongodump --out=dump.out
2020-11-04T06:26:23.154+0000    writing admin.system.version to dump.out/admin/system.version.bson
2020-11-04T06:26:23.155+0000    done dumping admin.system.version (1 document)
2020-11-04T06:26:23.155+0000    writing testdb.member to dump.out/testdb/member.bson
2020-11-04T06:26:23.156+0000    done dumping testdb.member (1 document)
2020-11-04T06:26:23.156+0000    writing testdb.clients to dump.out/testdb/clients.bson
2020-11-04T06:26:23.157+0000    done dumping testdb.clients (1 document)
```

### dump specified collection
```
mongodump  --db=test --collection=records

```

### dump excluding specified collections
```
mongodump  --db=test --excludeCollection=users --excludeCollection=salaries
```

## mongorestore
    mongorestore <options> <connection-string> <directory or file to restore>

```
[root@f3d7ecd9cb6a ~]# mongorestore dump.out/
2020-11-04T06:42:12.532+0000    preparing collections to restore from
2020-11-04T06:42:12.533+0000    restoring to existing collection testdb.clients without dropping
2020-11-04T06:42:12.533+0000    reading metadata for testdb.clients from dump.out/testdb/clients.metadata.json
2020-11-04T06:42:12.533+0000    restoring to existing collection testdb.member without dropping
2020-11-04T06:42:12.533+0000    reading metadata for testdb.member from dump.out/testdb/member.metadata.json
2020-11-04T06:42:12.533+0000    restoring testdb.clients from dump.out/testdb/clients.bson
2020-11-04T06:42:12.534+0000    restoring testdb.member from dump.out/testdb/member.bson
2020-11-04T06:42:12.672+0000    continuing through error: E11000 duplicate key error collection: testdb.member index: _id_ dup key: { _id: ObjectId('5fa10993a4e7134546540b63') }
2020-11-04T06:42:12.672+0000    continuing through error: E11000 duplicate key error collection: testdb.clients index: _id_ dup key: { _id: ObjectId('5fa2101a9d50e668f37224c6') }
2020-11-04T06:42:12.672+0000    restoring indexes for collection testdb.member from metadata
2020-11-04T06:42:12.672+0000    no indexes to restore
2020-11-04T06:42:12.672+0000    finished restoring testdb.clients (0 documents, 1 failure)
2020-11-04T06:42:12.673+0000    finished restoring testdb.member (0 documents, 1 failure)
2020-11-04T06:42:12.673+0000    0 document(s) restored successfully. 2 document(s) failed to restore.
```

## mongo export /import 
JSON or CSV File export / import 



* https://docs.mongodb.com/database-tools/mongodump/
* https://docs.mongodb.com/database-tools/mongorestore/#bin.mongorestore 
