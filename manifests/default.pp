
exec { 'get_percona_pkg':
	command => "/usr/bin/wget -O /tmp/percona-mysql.deb https://repo.percona.com/apt/percona-release_0.1-3.$(lsb_release -sc)_all.deb",
	notify => Package['percona-mysql'],
}

package { 'percona-mysql':
	name => "percona-mysql.deb",
	ensure => present,
	provider => dpkg,
	source => "/tmp/percona-mysql.deb",
	notify => Exec['apt-update']
}

#execute apt-get update
exec { 'apt-update':
	command      => '/usr/bin/apt-get update',
	# notify => Exec['install_percona-server-server-5.7'],
}

# package { 'percona-server-server-5.7':
# 	require => Exec['apt-update'],
# 	ensure => installed,
# 	# notify => Exec['create-replication-user']
# }

# #create replication user
# exec { 'create-replication-user':
# 	command      => '/usr/bin/mysql -e "CREATE USER \'replication\'@\'%\' IDENTIFIED BY \'passw0rd\';"',
# 	notify => Exec['grant-replication-user']
# }
# #grant replication user
# exec { 'grant-replication-user':
# 	command      => '/usr/bin/mysql -e "GRANT REPLICATION SLAVE ON *.* TO \'replication\'@\'%\';"',
# 	# notify => Exec['install_percona-server-server-5.7'],
# }

class { 'mysql::server':
  root_password 	=> 'password',
  package_name   	=> 'percona-server-server-5.7',
  enable_service    => true,
  ensure_running    => $ensure_running,
}
mysql::db{ ['test1']:
  user     => 'replication',
  password => 'passw0rd',
  ensure  => present,
  host     => 'localhost',
  grant    => ['all'],
  charset => 'utf8',
  require => Class['mysql::server'],
}


# file { '/tmp/eric/foo':
# 	ensure => directory,
# 	owner => "vagrant",
# 	group => "vagrant",
# 	mode => 750,
# }

package { 'vim':
	require => Exec['apt-update'],
	ensure => installed,
}


#create directory
file { '/home/vagrant/my-projects':
	ensure => directory,
	owner => "vagrant",
	group => "vagrant",
	mode => 750,
}
