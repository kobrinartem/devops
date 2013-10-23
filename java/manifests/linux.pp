class java::linux($version=undef) {

  exec { "update-apt-repository-oracle":
    command => "/usr/bin/apt-get update",
  }


  exec { "add-apt-repository-oracle":
    command => "/usr/bin/add-apt-repository -y ppa:webupd8team/java",
    notify => Exec["update-apt-repository-oracle"],


  }

  exec {
    'set-licence-selected':
      command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections';

    'set-licence-seen':
      command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections';
  }
  if $version == 'java6'{

  package { 'oracle-java6-installer':
    ensure => "installed",
    require => [Exec['add-apt-repository-oracle'], Exec['set-licence-selected'], Exec['set-licence-seen']],
  }
  }

  elsif $version == 'java7'{

  package { 'oracle-java7-installer':
    ensure => "installed",
    require => [Exec['add-apt-repository-oracle'], Exec['set-licence-selected'], Exec['set-licence-seen']],
  }

  }

  else {
  fail("Please choose version: java6 or java7")
  }
}
