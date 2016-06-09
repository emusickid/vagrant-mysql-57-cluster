class consul {
  exec { 'unzip-consul':
    command => '/usr/bin/unzip consul_0.6.4_linux_amd64.zip',
  }

  exec { 'install-consul':
    require => Exec['unzip-consul'],
    command => '/bin/mv consul  /usr/local/bin/',
  }

  file {'/etc/consul.d':
    ensure => 'directory',
  }

  file{'/etc/consul.d/read_only_healthcheck.sh':
    ensure  => present,
    content => template('read_only_healthcheck.sh.erb'),
    require => File['/etc/consul.d'],
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
  }

  exec { 'create-consul-db-service':
    require => File['/etc/consul.d'],
    command => '/bin/echo \'{"service": {"name": "db", "tags": ["mysql"], "port": 3306}}\' >/etc/consul.d/db.json;'
  }

  exec { 'create-consul-readonly-healthcheck':
    require => File['/etc/consul.d/read_only_healthcheck.sh'],
    command => '/bin/echo \'{"check": {"name": "read_only", "script": "/bin/bash /etc/consul.d/read_only_healthcheck.sh", "interval": "5s"}}\' >/etc/consul.d/read_only.json'
  }

  if 'consul-server' in $vmserver {
    file{'/home/failover-master.sh':
      ensure  => present,
      content => template('failover-master.sh.erb'),
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
    } 
    file{'/home/load-test':
      ensure  => present,
      content => template('load-test.erb'),
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
    }
    file{'/home/start-consul-server':
      ensure  => present,
      content => template('start-consul-server.erb'),
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
    }
    file{'/home/my-swap-master':
      ensure  => present,
      content => template('my-swap-master.erb'),
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
    }
  }
  else{
    file{'/home/start-consul-agent':
      ensure  => present,
      content => template('start-consul-agent.erb'),
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
    }
  }    
}