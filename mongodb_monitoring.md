# Mongodb Monitoring 
## PMM2 

### Install docker from Docker-ce repository
```
yum install -y -q yum-utils device-mapper-persistent-data lvm2 
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo 
yum install -y -q docker-ce 

systemctl enable docker 
systemctl start docker
```



### Install PMM Server with docker
```
docker create -v /srv --name pmm-data percona/pmm-server:2 /bin/true
docker run -d -p 80:80 -p 443:443 --volumes-from pmm-data --name pmm-server --restart always percona/pmm-server:2
```


### Install PMM Client
```
sudo yum install https://repo.percona.com/yum/percona-release-latest.noarch.rpm

sudo yum update
sudo yum install pmm2-client -y
```

### Create profile/user 

```json
db.createRole({
    role: "explainRole",
    privileges: [{
        resource: {
            db: "",
            collection: ""
            },
        actions: [
            "listIndexes",
            "listCollections",
            "dbStats",
            "dbHash",
            "collStats",
            "find"
            ]
        }],
    roles:[]
})

db.getSiblingDB("admin").createUser({
    user: "pmm",
    pwd: "pmm",
    roles: [
        { role: "clusterMonitor", db: "admin" },
        { role: "readAnyDatabase", db: "admin" }
    ]
})
```

### Enabling Profiling in the Configuration File (/etc/mongod.conf)
```json
operationProfiling:
   slowOpThresholdMs: 200
   mode: slowOp
```



### Configure PMM
sudo pmm-admin config --server-insecure-tls --server-url=https://admin:admin@<IP Address>:443

주의사항: net interface가 여러개일경우 엉뚱한 인터페이스  사용할수있음
ip 지정필요


```bash
* node0 
sudo pmm-admin config 172.16.20.100 --server-insecure-tls --server-url=https://admin:admin@172.16.200.101:443

pmm-admin add mongodb --username=pmm --password=admin mongo0 127.0.0.1:27017

* node1
sudo pmm-admin config 172.16.20.101 --server-insecure-tls --server-url=https://admin:admin@172.16.200.101:443

pmm-admin add mongodb --username=pmm --password=admin mongo1 127.0.0.1:27017

* node2 
sudo pmm-admin config 172.16.20.102 --server-insecure-tls --server-url=https://admin:admin@172.16.200.101:443
```

### Reference
* https://www.percona.com/blog/2019/09/19/installing-percona-monitoring-and-management-pmm-2-for-the-first-time/
* https://www.percona.com/blog/2020/08/05/how-to-manually-remove-client-instances-from-percona-monitoring-and-management-2/