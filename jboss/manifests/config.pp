class jboss_qa::config{
        $require = Class["jboss_qa::install"]

        exec { 'unzip jboss':
                command => 'unzip /tmp/jboss-5.1.0.GA-jdk6.zip -d /opt/ && chown jboss:jboss /opt/jboss-5.1.0.GA -R',
                path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
                cwd => '/opt/',
                creates => '/opt/jboss-5.1.0.GA/copyright.txt',
		require => Package[unzip],
                

                
        }	


        augeas { "sshd_config":
                context => "/files/etc/ssh/sshd_config",
                changes => "set UsePAM no",
                notify => Service["ssh"],
        }


	
    	augeas { "sudojboss":
        	context => "/files/etc/sudoers",
        	changes => [
            		"set spec[user = 'jboss']/user jboss",
            		"set spec[user = 'jboss']/host_group/host ALL",
            		"set spec[user = 'jboss']/host_group/command /etc/init.d/jboss",
            		"set spec[user = 'jboss']/host_group/command/tag NOPASSWD",
        		],
    	}

        augeas { "sudobmaster":
                context => "/files/etc/sudoers",
                changes => [
                        "set spec[user = 'bmaster']/user bmaster",
                        "set spec[user = 'bmaster']/host_group/host ALL",
                        "set spec[user = 'bmaster']/host_group/command /etc/init.d/jboss",
                        "set spec[user = 'bmaster']/host_group/command/tag NOPASSWD",
                        ],
        }

	ssh_authorized_key {
        	"jboss@${hostname}":
                	ensure  => present,
                	user    => bmaster,
                	type    => "ssh-rsa",
                	key     => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCxCItBEXCBlPthB+g+Dz2TtcrgHmO557gkwhzUvBmKr4hLwlP5qmv/QEeP9m2BLOHGrUO72ivAmJbghcdVgZulYclHglaDFwvfVnnGepkvQXZwvTS91BTIHmIMeB9IJqihHEsAjfoweIxbHaRJ9jzrPttlWiAxpDKMWe6H2pAlkdMeGg159XQPmjf29ToMD4eznyGa0u7vnlbTwqLYKNR74de5DlK4Xx72eNWBopfuQrYlP2y6sSY97kEnAAqgMsPfCeAkRhvDFX0KwRe/1wpPI8fEQYiB3T+fwb0X/2cZwFBGE7RLFwMhnGhZTh53VkStD1LP5cKZ1TCwOsxkSGkf",
			require => File['/opt/jboss-5.1.0.GA/.ssh'],


}

        ssh_authorized_key {
                "root@${hostname}":
                        ensure  => present,
                        user    => root,
                        type    => "ssh-rsa",
                        key     => "AAAAB3NzaC1yc2EAAAADAQABAAACAQCvQ/Dt6hKM7M3WE/mJHaxCdDrNgoj8prOzWZMLtIwnlW06KnKl+Q2TgM58/xvdiBEXNLQ/z1AB2rghXhVAy6QX+QuS1arJVFcqfMEx7qFUrEPNQlc126hLH9SSYd9wV7uzN08eyfmv69ck2W3H2iQ1v8kiM2424gBAqXy+bVYAqaOw4IdXY7z8dY2+tOI/+BoPXWT822ksXDNvhO9paPhp9DbXRKWoq5SXdNcCdEWm1CgMXKTHRliRS96+qNWQoxFMN+YE6sA41G8mngAk0tlTNFBpq0UhJsAwm5rfFk5x7HD+QALIVQ5yl0AD5aVyfqXOexZasw/7Q5o+Thg5mp2sJkdell4F9XO0gXajoAkNGNu7EOa29N7RTHTcMk7JU1oM3d3dGlmY4YP0qy3ijiKrjIyE1qXX01149Fxd63P+uj0R6r+qYb4/D75dfRYRzAOlyz4TyVdu4pxcOJLq/3OYGM0pegU/L8HQQGJv/wsGYx+xpvEjrMD9i99yZ5XA5jVSE0CjC24y4St68uKSrc43YTHfg7HY0R1mAhwlzk6wQTbRzC+RV09knVgCHpdyqf6nVixkQufgT3KVM3pAWc90+3GwiOcMBP2vABUUlZ/e9UihZ41WDBzs3qn/pGDnRLhxpUoOqa936vNxugpFuzZwktyT5sXJwEbB3rfufUoL6Q==",
}

}
