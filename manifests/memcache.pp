#memcache
 package { 'memcached':
        ensure => present,
        #require => Exec['apt-get update']
    }
    