class java::install  inherits java::params {        

   if $::osfamily == windows {
	file { 'java_installer':
                path    => $java::params::temp_java,
                ensure  => file,
                mode    => 775,
                source  => $java::params::java_pkg,
        }
        exec { 'jre-7u25-windows-install':
                command => $java::params::command_install_java,
                creates => "${java::params::java_dst}\\bin\\java.exe",
		require => File['java_installer']
        }
   }
   if $::osfamily == Debian {

	   apt::ppa { 'ppa:webupd8team/java': }

	   exec {'set-licence-seen':
	   	command    => '/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections',
		onlyif     => '/usr/bin/debconf-get-selections | /bin/grep "accepted-oracle-license-v1-1"|/usr/bin/wc -l|/bin/grep 0',
		require    => Apt::Ppa['ppa:webupd8team/java']
	   }

	   package { $java_pkg:
		ensure      => "installed",
		require => Exec['set-licence-seen'],
	   }

   
   
   
   }

}
