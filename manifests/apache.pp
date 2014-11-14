#Apache
package { ['php5', 'apache2', 'git-core']:
    ensure => installed,
}

exec  {'apache_stop':
	path => '/usr/bin',
	command => 'service apache2 stop',
	require => Package['apache2'],
}

file {'/etc/apache2/sites-available/000-default.conf':
	source  => '/vagrant/apache/etc/apache2/sites-enabled/000-default',
	ensure => 'present',
	owner   => 'root',
	group   => 'root',
	mode    => '777',
	require => Exec['apache_stop'],
	notify  => Exec['apache_start'],
	#notify  => File['/etc/apache2/apache2.conf'],
}



define apache::loadmodule () {
     exec { "/usr/sbin/a2enmod $name" :
        unless => "/bin/readlink -e /etc/apache2/mods-enabled/${name}.load",
        require => Exec['apache_stop'],
		notify  => Exec['apache_start'],
     }
}

apache::loadmodule{"rewrite": }
apache::loadmodule{"headers": }

#file {'/etc/apache2/apache2.conf':
#	source  => '/vagrant/apache/etc/httpd.conf',
#	ensure => 'present',
#	owner   => 'root',
#	group   => 'root',
#	mode    => '777',
#	require => Exec['apache_stop'],
#	notify  => Exec['apache_start'],

#}


#file {'/etc/apache2/mods-enabled/rewrite.load':
#	source  => '/etc/apache2/mods-available/rewrite.load',
#	ensure => 'present',
#	owner   => 'root',
#	group   => 'root',
#	mode    => '777',
#	require => Exec['apache_stop'],
#	notify  => Exec['apache_start'],
#}

exec  {'apache_start':
	path => '/usr/bin',
	command => 'sudo service apache2 start',
}
