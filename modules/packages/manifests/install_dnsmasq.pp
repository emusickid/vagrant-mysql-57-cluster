class packages::install_dnsmasq {

  Package { ensure => 'installed', require => Exec['apt-update']}

  package { 'dnsmasq': }


  file {'/etc/dnsmasq.d/10-consul':
    ensure  => present,
    notify  => Service['dnsmasq'], 
    content => template('10-consul.erb'),
    require => Package['dnsmasq'],
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
  }

  service { 'dnsmasq':
      ensure  => 'running',
      enable  => true,
      require => Package['dnsmasq'],
  }
}