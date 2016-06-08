class packages::apt_update {
	exec { 'apt-update':
	  command  => '/usr/bin/apt-get update',
	}
}