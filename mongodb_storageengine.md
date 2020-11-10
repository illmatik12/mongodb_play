# MongoDB Storage Engine
## Wired Tiger
* WiredTiger uses MultiVersion Concurrency Control (MVCC). At the start of an operation, WiredTiger provides a point-in-time snapshot of the data to the operation. A snapshot presents a consistent view of the in-memory data.
* MongoDB sets checkpoints to occur in WiredTiger on user data at an interval of 60 seconds or when 2 GB of journal data has been written, whichever occurs first. 

During the write of a new checkpoint, the previous checkpoint is still valid. As such, even if MongoDB terminates or encounters an error while writing a new checkpoint, upon restart, MongoDB can recover from the last valid checkpoint.

The new checkpoint becomes accessible and permanent when WiredTiger’s metadata table is atomically updated to reference the new checkpoint. Once the new checkpoint is accessible, WiredTiger frees pages from the old checkpoints.

Using WiredTiger, even without journaling, MongoDB can recover from the last checkpoint; however, to recover changes made after the last checkpoint, run with journaling.

## journal 
WiredTiger journal 방식의 write ahead log 를 사용. 
journal에 모든 replay 데이터를 저장. 
snappy 압축 사용. 

## Compression 
- MongoDB는 collection과 index에 대해 압축을 사용.
- 압축은 추가적인 cpu를 사용함. 

## Memory Use 
- 50% of (RAM - 1 GB), or
- 256 MB.

## Cache size 
* storage.wiredTiger.engineConfig.cacheSizeGB 
