
sudo apt-get install -y unzip;
wget https://dl.bintray.com/mitchellh/consul/0.5.2_linux_amd64.zip;
unzip 0.5.2_linux_amd64.zip -d /usr/local/bin;
consul;




sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A;
echo "deb http://repo.percona.com/apt "$(lsb_release -sc)" main" | sudo tee /etc/apt/sources.list.d/percona.list;
echo 'deb-src http://repo.percona.com/apt '$(lsb_release -sc)' main' | sudo tee -a /etc/apt/sources.list.d/percona.list;
sudo apt-get update;
apt-get install percona-server-server-5.6
