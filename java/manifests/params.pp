class java::params{

	#$java_bin is variable for jboss (JAVAPTH in jboss init script)
	


        case $::osfamily {

                Debian: {
			if $java::version == 'java6'{
				$java_pkg=['oracle-java6-installer','oracle-java6-set-default']
				$java_bin='/usr/lib/jvm/java-6-oracle/jre/bin/'
			}
                        if $java::version == 'java7'{
                                $java_pkg=['oracle-java7-installer','oracle-java7-set-default']
				$java_bin='/usr/lib/jvm/java-7-oracle/jre/bin/'
                        }
                }

                windows: {
                        $temp_dir = 'C:\windows\temp'
                        $temp_java="${java::params::temp_dir}\\${java::version}.exe"
			$java_root='C:\java'
			if $java::version == 'java6'{
			        $java_pkg='puppet:///modules/java/jre-6u45-windows-x64.exe'
				$java_dst="${java_root}\\jre6"
				$java_bin="${java_dst}\\bin"
			}
			if $java::version == 'java7'{
			        $java_pkg='puppet:///modules/java/jre-7u25-windows-i586.exe'
				$java_dst="${java_root}\\jre7"
				$java_bin="${java_dst}\\bin"
			}
                        $command_install_java = "${java::params::temp_java} /s ADDLOCAL=ALL IEXPLORER=1 INSTALLDIR=${java_dst}"
                }

                default: {
                        err("Module java is not supported on ${::operatingsystem}")
                }

        }
}

