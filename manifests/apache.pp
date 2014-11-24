#Apache
package { ['php5', 'apache2', 'git-core', 'subversion']:
    ensure => installed,
}

exec  {'apache_stop':
	path => '/usr/bin',
	command => 'service apache2 stop',
	require => Package['apache2'],
}

exec  {'apache_start':
	path => '/usr/bin',
	command => 'sudo service apache2 start',
}


file {'/etc/apache2/sites-enabled/ch9.conf':
	source  => '/vagrant/apache/etc/apache2/sites-enabled/ch9.conf',
	ensure => 'file',
	owner   => 'root',
	group   => 'root',
	mode    => '777',
	require => Exec['apache_stop'],
	notify  => Exec['apache_start'],
	#notify  => File['/etc/apache2/apache2.conf'],
}

file {'/etc/apache2/apache2.conf':
	source  => '/vagrant/apache/apache2.conf',
	ensure => 'file',
	owner   => 'root',
	group   => 'root',
	mode    => '777',
	require => Exec['apache_stop'],
	notify  => Exec['apache_start'],
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
