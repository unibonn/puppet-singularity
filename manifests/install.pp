class singularity::install {

	if $singularity::manage_repo {
		if $facts['os']['family'] == 'RedHat' {
			if $singularity::use_repo_urls {
				yumrepo { 'singularity':
					ensure		=> $singularity::repo_ensure,
					descr		=> 'Singularity Container',
					baseurl		=> $singularity::repo_url,
					gpgcheck	=> $singularity::repo_gpgcheck,
					gpgkey		=> $singularity::repo_gpgkey,
				}
				$pkgrequire = Yumrepo['singularity']
			} else {
				ensure_packages(['epel-release'])
				$pkgrequire = Package['epel-release']
			}
		} elsif $facts['os']['family'] == 'Debian' {
			if ! defined(Class['::apt']) {
				fail("${module_name}: You must include the apt class before using the singularity class if manage_repo is true")
			}
			if $singularity::use_repo_urls {
				apt::source { 'singularity':
					allow_unsigned	=> $singularity::repo_gpgcheck ? { false => true, true => false },
					ensure		=> $singularity::repo_ensure,
					comment		=> 'Singularity Container',
					location	=> $singularity::repo_url,
					key		=> {
						id	=> $singularity::repo_gpgkey_id,
						source	=> $singularity::repo_gpgkey,
					},
					release		=> '/',
					repos		=> '',
					notify_update	=> true,
					require		=> Class['::apt'],
				}
				$pkgrequire = Apt::Source['singularity']
			} else {
				fail("${module_name}: You did not specify 'use_repo_urls' which is needed for Debian, giving up!")
			}
		} else {
			$pkgrequire = undef
		}
	} else {
		$pkgrequire = undef
	}

	if $singularity::runtime_package_only and $facts['os']['family'] == 'Debian' {
		fail("${module_name}: runtime only installations are not supported on OSes of the Debian family")
	} elsif $singularity::runtime_package_only {
		ensure_packages([$singularity::runtime_package_name],
				{
					ensure	=> $singularity::package_ensure,
                                  	require	=> $pkgrequire,
				}
		)
		ensure_packages([$singularity::package_name],
				{
					ensure	=> 'absent',
				}
		)
	}
	else {
		ensure_packages([$singularity::package_name],
				{
					ensure	=> $singularity::package_ensure,
				  	require	=> $pkgrequire,
				}
		)
	}

}
