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
	}
	
	$pkgrequire = $singularity::manage_repo ? {
		true	=> Yumrepo['singularity'],
		false	=> undef,
	}

	package { 'singularity':
		ensure	=> $singularity::package_ensure,
		require	=> $pkgrequire,
	}

}
