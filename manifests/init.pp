exec { 'get_percona_pkg':
  command => "/usr/bin/wget -O /tmp/percona-mysql.deb https://repo.percona.com/apt/percona-release_0.1-4.$(lsb_release -sc)_all.deb; /usr/bin/dpkg -i /tmp/percona-mysql.deb",
}
include packages::apt_update
include packages::install_core
include packages::install_dnsmasq
include packages::percona_server
# include consul
# include database::server

Class['packages::install_core'] ->
Class['packages::install_dnsmasq'] ->
Class['packages::percona_server'] ->
# Class['consul']

#create directory
file { '/home/vagrant/my-projects':
  ensure => directory,
  owner => "vagrant",
  group => "vagrant",
  mode => 750,
}