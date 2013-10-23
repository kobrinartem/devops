class base::params{
        case $::osfamily{

                Debian: {
                        $pkg=['ntp', 'htop', 'vim-puppet', 'augeas-tools', 'git', 'vim', 'python-software-properties','unzip']
                        $pvd='apt'
			$srv=['ntp']
			
                }

                windows: {
                        $pkg=['notepadplusplus','7zip','GoogleChrome','git','filezilla','Console2']
			$pvd='chocolatey'
			$install_options='-pre'
                }

                default: {
                        err("Module base is not supported on ${::operatingsystem}")
                }

        }



}
