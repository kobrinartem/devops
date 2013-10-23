class jboss::params{

	# point to java module for get the variable
	$java_home = $java::params::java_bin

        case $::osfamily {

                Debian: {
                        $root='/opt'
                        $jboss_dir="${root}/jboss"
                        $temp_dir='/tmp'
			$temp_jboss="${jboss::params::temp_dir}/jboss.zip"
                        $command_unzip_jboss = "/usr/bin/unzip ${jboss::params::temp_jboss} -d ${jboss::params::jboss_dir}"
			$unzip_req = [Package['unzip'], File[$jboss::params::temp_jboss]]
			$jboss_home = "${jboss::params::jboss_dir}/${jboss::jboss_version}"
                }

                windows: {
                        $root = 'C:'
                        $jboss_dir = "${root}\\jboss"
                        $temp_dir = 'C:\windows\temp'
			$temp_jboss="${jboss::params::temp_dir}\\jboss.zip"
                        $7z_path = '"C:\Program Files\7-Zip\7z.exe"'
                        $command_unzip_jboss = "${jboss::params::7z_path} x ${jboss::params::temp_jboss} -o${jboss::params::jboss_dir}"
			$unzip_req = [Package['7zip'], File[$jboss::params::temp_jboss]]
			$jboss_home = "${jboss::params::jboss_dir}\\${jboss::jboss_version}"
                }

                default: {
                        err("Module jboss is not supported on ${::operatingsystem}")
                }

        }
}
