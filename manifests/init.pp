# == Class: mysql
#
# Installs MySQL server, sets config file, and loads database for dynamic site.
#
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

class { 'mysql::server':
  root_password   => 'password',
  package_name    => 'percona-server-server-5.7',
  override_options => {
    'mysqld' => {
      'server-id' => '1',
      'log-slave-updates' => '1',
      'log-bin' => 'mysql-bin',
      'binlog_format' => 'MIXED',
      'enforce-gtid-consistency' => '',
      'gtid-mode'=> 'ON',
    }
  }
}

mysql_user{ 'replication@%':
  ensure        => present,
  password_hash => mysql_password('blah'),
  notify        =>  Exec['grant-replication-user'],
}
#grant replication user
exec { 'grant-replication-user':
  command      => '/usr/bin/mysql -e "GRANT REPLICATION SLAVE ON *.* TO \'replication\'@\'%\';"',
}



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