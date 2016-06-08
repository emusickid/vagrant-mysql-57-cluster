
include packages::apt_update
include packages::install_core
include packages::install_dnsmasq
include packages::percona_server
include consul
# include database::server

Class['packages::install_core'] ->
Class['packages::install_dnsmasq'] ->
Class['packages::percona_server'] ->
Class['consul']



#create directory
file { '/home/vagrant/my-projects':
  ensure => directory,
  owner => "vagrant",
  group => "vagrant",
  mode => 750,
}