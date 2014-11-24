#varnish
package { ['varnish']:
    ensure => installed,
}

file {'/etc/varnish/default.vcl':
	source  => '/vagrant/varnish/etc/varnish/default.vcl',
	ensure => 'file',
	owner   => 'root',
	group   => 'root',
	mode    => '700',
	require => Package['varnish'],
}

exec { "varnish_start":
	path => ["/bin", "/usr/bin", "/usr/sbin"],
	cwd => "/vagrant/varnish",
	command => "sudo pkill varnishd && sudo varnishd -f /etc/varnish/default.vcl -s malloc,300MB -a :81",
	require => File['/etc/varnish/default.vcl'],
}
