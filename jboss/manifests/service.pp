class jboss::service inherits jboss::params, jboss::install, jboss::unzip, jboss::env {

    if $::osfamily == Debian {

        service { 'jboss':
                ensure  => "running",
                enable  => "true",
        }
   
    }

}
