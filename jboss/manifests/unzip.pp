class jboss::unzip  inherits jboss::install {
$require = Class["jboss::install"]
        exec { 'unzip jboss':
                command => $jboss::params::command_unzip_jboss,
                creates => $jboss::params::jboss_home,
                require => $jboss::params::unzip_req,
        }

}
