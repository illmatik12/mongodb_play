# MongoDB 
- C++ 작성됨.
- Schemaless (Schema-free)


## Data Model 

- DB는 Collection들의 물리적인 컨테이너. 각 Database는 파일시스템에 여러파일들로 저장됨.
- Collection(Table) - MongoDB Docdument의 그룹
- Document(Record)
- Key:value(Field)
- json format의 document 

## mongodb hierarchy
- db -> collection -> document -> key:value

## Schemaless(Schema-free)

- Schema? 
  데이터베이스를 구성하는 개체(Entity),속성(Attribute), 관계(Relationship) 및 데이터 조작시에 데이터 값들이 갖는 제약조건 등에 관해 정의하는 것.
  Schema는 그 구조가 미리 정의되어 있어야 하며 이는 급격한 데이터의 변화에 대응하기 힘듬.
- MongoDB는 이런 스키마가 사전 정의되지 않아도 됨. 
- 데이터베이스에 저장된 Document는 각기 다른, 다양한 필드를 가질 수 있다.
- 각 필드는 서로 다른 데이터타입을 가질 수 있다.
- 비 구조화된 데이터에 대해 쉽게 저장 가능.

## Document Oriented(Uses BSON,Binary JSON format)
- Join 대신 Embeded document 활용 가능.
- Dynamic schema는 다형성(polymorphism)을 가능케 함.

## Deep query-ability 
- 강력한 쿼리 기능 사용 
- javascript expression
- Key-value queries : return results based on any field in the document, often the primary key.
Range queries : return results based on values defined as inequalities (e.g. greater than, less than or equal to, between).
- Geospatial queries: return results based on proximity criteria, intersection and inclusion as specified by a point, line, circle or polygon.
- Search queries: return results in relevance order and in faceted groups, based on text arguments using Boolean operators (e.g., AND, OR, NOT), and through bucketing, grouping and counting of query results. With support for collations, data comparison and sorting order can be defined for over 100 different languages and locales.
- (built in) Aggregation Framework queries : return aggregations and transformations of values returned by the query (e.g., count, min, max, average, similar to a SQL GROUP BY statement).
- JOINs and graph traversals : Through the $lookup stage of the aggregation pipeline, documents from separate collections can be combined through a left outer JOIN operation. $graphLookup brings native graph processing within MongoDB, enabling efficient traversals across trees, graphs and hierarchical data to uncover patterns and surface previously unidentified connections.
MapReduce queries : execute complex data processing that is expressed in JavaScript and executed across data in the database.

## Aggregation 
- GROUP BY 
- HAVING 
- MIN,MAX

## Indexing 
- RDBMS인 MySQL에서 지원하는 대부분의 인덱스를 지원
- Index는 메모리에 저장되기 때문에 메모리 크기에 영향을 많이 받는다.
    - Adhoc 쿼리 지원 : (미리 정의되지 않은 쿼리. 동적으로 변하는 쿼리 )
    - Single Field Indexes : 가장 기본적인 인덱스 타입
    - Compound Indexes : RDBMS에서 많이 쓰이는 복합 인덱스
    - Multikey Indexes : Array에 매칭되는 값이 하나라도 있으면 인덱스에 추가하는 멀티키 인덱스
    - Geospatial Indexes and Queries : 위치 기반 인덱스와 쿼리
    - Text Indexes : String 컨텐츠에도 인덱싱이 가능
    - Hashed Index : BTree 인덱스가 아닌 Hash 타입의 인덱스도 사용 가능

## Fixed Size Collection
- Capped collections 라고도 불린다.
- Collection의 사이즈를 고정할 수 있으며 , 큐 처럼 동작함.

## Supports Multiple Storage Engines
- mongodb multiple storage engine
- 스토리지 엔진: 데이터가 어떤식으로 저장되는지 매니징 하는 엔진
    - WiredTiger Storage Engine (최신 버전의 Default) 
    - MMAPv1 Storage Engine (과거 버전의 Default)
    - Third party storage engine 을 적용할 수 있는 API를 제공


## Fast In-Place Updates
- https://www.mongodb.com/blog/post/fast-updates-with-mongodb-update-in-place
- 고성능의 atomic operation을 지원

## GridFS
- 대용량 파일을 저장하기 위한 Grid File System.
- MongoDB 는 document 하나의 크기가 최대 16MB 로 제한된다.
그 이상의 파일을 저장하기 위해서 Large File을 작은 파트로 분할해서 분리된 Documents 로 저장하는 MongoDB driver 를 제공한다.
해당 컨텐츠를 요구하면 분리된 작은 Chunks를 자동으로 모아서 오리지널 파일을 반환한다.
- 별도 스토리지 엔진을 통해 파일을 저장가능
- image/video PDFs, PPT slides or Excel spreadsheets 와 같은 컨텐츠의 저장소로 활용이 가능하다.
- GridFS는 16MB(BSON document 사이즈) 넘는 사이즈의 데이터를 저장하고 조회 하는 방법.
- 한개의 파일로 저장하는 대신에 부분이나 청크로 나누어 분리된 도큐먼트를 청크로 저장한다. 청크사이즈는 기본 256k로 제한되어 있다. 파일 청크와 메타데이터를 저장하는 두개의 컬렉션을 사용한다

## 제한사항(Restriction)
- Join 불가
- Transaction 처리 (현재도 그런지 ?)

## Data 저장 방식 (RDB 와의 차이 정리)

## Auto-Sharding 

## Mongodb Replica Set(Privides high availability)
- Master-Slave Replication
- 마스터는 읽기+쓰기, 슬레이브는 read 
- Automatic Fail-over


## 참고 
- https://nicewoong.github.io/development/2018/02/10/mongodb-feature/
- https://www.slideshare.net/NorbertoLeite/mongodb-wiredtiger-internals
- https://www.mongodb.com/mongodb-architecture