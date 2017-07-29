class singularity::install {

	if $singularity::manage_repo {
		if $facts['os']['family'] == 'RedHat' {
			yumrepo { 'singularity':
				ensure		=> $singularity::repo_ensure,
				baseurl		=> $singularity::repo_url,
				gpgcheck	=> $singularity::repo_gpgcheck,
				gpgkey		=> $singularity::repo_gpgkey,
			}
		}
		elsif $facts['os']['family'] == 'Debian' {
			if ! defined(Class['::apt']) {
				fail("${module_name}: You must include the apt class before using the singularity class if manage_repo is true")
			}
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
		}
	}

	$pkgrequire = $singularity::manage_repo ? {
		true	=> $facts['os']['family'] ? { 'RedHat' => Yumrepo['singularity'], 'Debian' => Apt::Source['singularity'] },
		false	=> undef,
	}

	package { $singularity::package_name:
		ensure	=> $singularity::package_ensure,
		require	=> $pkgrequire,
	}

}
