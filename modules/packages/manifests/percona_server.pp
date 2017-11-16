class packages::percona_server {

  if 'master' in $vmserver {
    $mysqlconfig = {
      'mysqld'                     => {
        'bind-address'             => '0.0.0.0',
        'server-id'                => $serverid,
        'log-slave-updates'        => '1',
        'log-bin'                  => 'mysql-bin',
        'binlog_format'            => 'ROW',
        'enforce-gtid-consistency' => '',
        'gtid-mode'                => 'ON',
        'early-plugin-load'        => 'keyring_file.so',
        'keyring_file_data'        => '/usr/local/mysql/mysql-keyring/keyring',
      }
    } 
  }
  else {
    $mysqlconfig = {
      'mysqld'                     => {
        'bind-address'             => '0.0.0.0',
        'server-id'                => $serverid,
        'log-bin'                  => 'mysql-bin',
        'binlog_format'            => 'ROW',
        'enforce-gtid-consistency' => '',
        'gtid-mode'                => 'ON',
        'relay-log'                => 'relay-log-slave',
        'read-only'                => 'ON',
        'early-plugin-load'        => 'keyring_file.so',
        'keyring_file_data'        => '/usr/local/mysql/mysql-keyring/keyring',
      }
    } 
  }

  #Used for en encryption and key_ring file tablespace encryption
  file {'/usr/local/mysql':
    ensure => 'directory',
  }

  file {'/usr/local/mysql/mysql-keyring':
    ensure => 'directory',
    owner  => 'mysql',
    group  => 'mysql',
    mode   => '750',
  }
  
  class { 'mysql::server':
    root_password    => 'password',
    package_name     => 'percona-server-server-5.7',
    override_options => $mysqlconfig,
  }

  mysql_user{ 'replication@%':
    ensure        => present,
    password_hash => mysql_password('passw0rd'),
    notify        =>  Exec['grant-replication-user'],
  }
  #grant replication user
  exec { 'grant-replication-user':
    command      => '/usr/bin/mysql -e "GRANT ALL PRIVILEGES ON *.* TO \'replication\'@\'%\';"',
    notify       =>  Exec['restart-mysql'],
  }

  exec { 'restart-mysql':
    command      => '/etc/init.d/mysql restart',
  }
}