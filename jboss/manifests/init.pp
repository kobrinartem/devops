class jboss(
        $jboss_source = 'puppet:///modules/jboss/jboss-5.1.0.GA-jdk6.zip',
        $jboss_init_script = 'jboss/jboss.erb',
        $jboss_version = 'jboss-5.1.0.GA'
	)
{

include jboss::install, jboss::params, jboss::unzip, jboss::env

}
