class java::windows ($version=undef) {

  if $version == 'java6'{

        file { 'jre-6u45-windows-x64.exe':
                path => 'C:/jre-6u45-windows-x64.exe',
                ensure => file,
                mode   => 775,
                source => 'puppet:///modules/java/jre-6u45-windows-x64.exe',
                before => Exec['jre-6u45-windows-install'],
        }
        exec { 'jre-6u45-windows-install':
                command => 'C:/jre-6u45-windows-x64.exe /s ADDLOCAL=ALL IEXPLORER=1 INSTALLDIR=C:\java\jre6',
                creates => 'C:/java/jre6/bin/java.exe',
        }
  }

  elsif $version == 'java7'{

        file { 'jre-7u25-windows-i586.exe':
                path => 'C:/jre-7u25-windows-i586.exe',
                ensure => file,
                mode   => 775,
                source => 'puppet:///modules/java/jre-7u25-windows-i586.exe',
                before => Exec['jre-7u25-windows-install'],
        }
        exec { 'jre-7u25-windows-install':
                command => 'C:/jre-7u25-windows-i586.exe  /s ADDLOCAL=ALL IEXPLORER=1 INSTALLDIR=C:\java\jre7',
                creates => 'C:/java/jre7/bin/java.exe',
        }
  }

  else {
  
    fail("Please choose version: java6 or java7")
}




}
