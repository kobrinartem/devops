class jboss::env  inherits jboss::params {
	

   if $::osfamily == windows{

	windows_env { 'JBOSS_HOME':
        	value     => $jboss::params::jboss_home,
                ensure    => present,
                type      => REG_EXPAND_SZ,
		mergemode => clobber,
        }
        windows_env { 'JAVA_HOME':
                value     => $jboss::params::java_home,
                ensure    => present,
                type      => REG_EXPAND_SZ,
		mergemode => clobber,
        }

    }


   if $::osfamily == Debian {
	file { 'jboss':
		path    => '/etc/init.d/jboss',
	        ensure  => file,
	        owner   => 'root',
	        group   => 'root',
	        mode    => 0755,
	        content => template($jboss::jboss_init_script),
	}
   }

}
