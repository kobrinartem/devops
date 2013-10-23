class base::service   inherits base::install {

  if $srv != undef {
      service { $srv:
        ensure    => running,
        enable    => true,
      }
  }
}
