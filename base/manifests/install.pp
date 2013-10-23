class base::install inherits base::params {



  if $pkg != undef {
    package { $pkg:
        ensure   => installed,
        provider => $pvd,
	install_options => $install_options,
    }
  }
}
