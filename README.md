# vagrant-mysql-57-cluster
A vagrant environment to test Percona Server 5.7 (MySQL) replication.

This vagrant environment will help in testing MySQL Master Master replication. The replication toplogy craeted in this environment is as follows:
  ```Master1 <====> Master2 ----> Slave1```.
To build the cluster:
``` /bin/bash bootstrap.sh```
