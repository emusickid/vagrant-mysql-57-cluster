class packages::install_core {

  Package { ensure => 'installed', require => Exec['apt-update']}

  package { 'curl': }
  package { 'unzip': }
  package { 'vim':   }
}