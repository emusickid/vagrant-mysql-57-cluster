#!/usr/bin/env bash

sudo -i
wget https://repo.percona.com/apt/percona-release_0.1-3.$(lsb_release -sc)_all.deb
dpkg -i percona-release_0.1-3.$(lsb_release -sc)_all.deb
debconf-set-selections <<< 'mysql-server mysql-server/root_password password passw0rd'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password passw0rd'
apt-get update
apt-get install -y percona-server-server-5.7
