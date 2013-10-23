class jboss::install  inherits jboss::params {


        file { "${jboss::params::temp_jboss}":
                ensure => file,
                source => $jboss::jboss_source,
        }

    if $::osfamily == Debian {

	user {'jboss':
                ensure  => present,
                home    => $jboss_home,

	}

	file {$jboss_dir:
		ensure  => "directory",
		owner   => "jboss",
		require => User['jboss'],
	
	}

    }

}
