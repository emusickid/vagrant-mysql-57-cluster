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
}