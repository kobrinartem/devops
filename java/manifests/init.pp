class java(
	$version='java6'
	)
{
	if $version == 'java6' or $version == 'java7'{
		 include java::params, java::install
	}
	else {
		fail("Please choose version: java6 or java7")
	}
}


