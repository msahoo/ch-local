#php
 package { [
      'php5',
      'php5-mysql',
      'php5-curl',
      'php5-gd',
      #'php5-fpm',
      'libapache2-mod-php5',
      'php5-dev',
      'php5-xdebug',
      'php-pear',
      'php5-memcached',
      'php5-memcache',
      'php-apc',
      'php5-mysqlnd',
 
    ]:
    ensure => present,
    }
  
    file {'/etc/php5/apache2/php.ini':
        source  => '/vagrant/php/php.ini',
        ensure => 'file',
        owner   => 'root',
        group   => 'root',
        mode    => '644',
        require => Package['php5'],
    }

    file {'/etc/php5/mods-available/xdebug.ini':
        source  => '/vagrant/php/xdebug.ini',
        ensure => 'file',
        owner   => 'root',
        group   => 'root',
        mode    => '644',
        require => Package['php5'],
    }

    # upgrade pear
    exec {"pear upgrade":
      command => "/usr/bin/pear upgrade",
      require => Package['php-pear'],
    }
    
    # set channels to auto discover
    exec { "pear auto_discover" :
        command => "/usr/bin/pear config-set auto_discover 1",
        require => [Package['php-pear']]
    }
    
    # update channels
    exec { "pear update-channels" :
        command => "/usr/bin/pear update-channels",
        require => [Package['php-pear']]
    }
