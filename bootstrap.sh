#!/bin/bash
export VM_SERVER="master-1"
export VM_IP="192.168.205.10"
export VM_SLAVE_IP="192.168.205.11"
export VM_SERVER_ID="1"
vagrant up master-1 --provision;
export VM_SERVER="master-2"
export VM_IP="192.168.205.11"
export VM_SLAVE_IP="192.168.205.10"
export VM_SERVER_ID="2"
vagrant up master-2 --provision;
export VM_SERVER="slave-1"
export VM_IP="192.168.205.12"
export VM_SLAVE_IP="192.168.205.10"
export VM_SERVER_ID="3"
vagrant up slave-1 --provision;
export VM_SERVER="consul-server"
export VM_IP="192.168.205.20"
export VM_SLAVE_IP="192.168.205.10"
export VM_SERVER_ID="4"
vagrant up consul-server --provision;

echo "Creating Replication on master-1."
vagrant ssh master-1 -c 'sudo mysql -e "CHANGE MASTER TO MASTER_HOST = '\''192.168.205.11'\'', MASTER_PORT = 3306, MASTER_USER = '\''replication'\'', MASTER_PASSWORD = '\''passw0rd'\'', MASTER_AUTO_POSITION = 1;"';
echo "Creating Replication on master-2."
vagrant ssh master-2 -c 'sudo mysql -e "CHANGE MASTER TO MASTER_HOST = '\''192.168.205.10'\'', MASTER_PORT = 3306, MASTER_USER = '\''replication'\'', MASTER_PASSWORD = '\''passw0rd'\'', MASTER_AUTO_POSITION = 1;"';
echo "Creating Replication on master-3."
vagrant ssh slave-1 -c 'sudo mysql -e "CHANGE MASTER TO MASTER_HOST = '\''192.168.205.10'\'', MASTER_PORT = 3306, MASTER_USER = '\''replication'\'', MASTER_PASSWORD = '\''passw0rd'\'', MASTER_AUTO_POSITION = 1;"';

vagrant ssh master-1 -c 'sudo mysql -e "start slave;"'
vagrant ssh master-2 -c 'sudo mysql -e "start slave;"'
vagrant ssh slave-1 -c 'sudo mysql -e "start slave;"'