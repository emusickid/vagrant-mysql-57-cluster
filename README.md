# vagrant-mysql-57-cluster
A vagrant environment to test Percona Server 5.7 (MySQL) replication.

This vagrant environment will help in testing MySQL Master Master replication. 

###The replication toplogy craeted in this environment is as follows:
  ```Master1 <====> Master2 ----> Slave1```.
## To build the cluster
``` /bin/bash bootstrap.sh```
## Connecting to the servers
- ```vagrant ssh master-1```
- ```vagrant ssh master-2```
- ```vagrant ssh slave-1```

## To remove the cluster
```
$ vagrant destroy
    slave-1: Are you sure you want to destroy the 'slave-1' VM? [y/N] y
    master-2: Are you sure you want to destroy the 'slave-1' VM? [y/N] y
    master-1: Are you sure you want to destroy the 'slave-1' VM? [y/N] y
```
