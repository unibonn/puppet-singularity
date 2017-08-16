class singularity::params {

	if ! $facts['os']['family'] == 'RedHat' and ! $facts['os']['family'] == 'Debian' {
		fail("singularity: This module does not support OSes of family ${facts['os']['family']}")
	}

	$allow_setuid		= true
	$max_loop_devices	= 256
	$allow_pid_ns		= true
	$enable_overlay		= true
	$config_passwd		= true
	$config_group		= true
	$config_resolv_conf	= true
	$mount_proc		= true
	$mount_sys		= true
	$mount_dev		= true
	$mount_devpts		= false
	$mount_home		= true
	$mount_tmp		= true
	$mount_hostfs		= false
	$user_bind_control	= true
	$mount_slave		= true
	$sessiondir_max_size	= 16
	$bind_path		= undef
	$limit_container_owners	= undef
	$limit_container_paths	= undef

	$manage_repo		= true
	$repo_ensure		= 'present'
	$obs_os_name		= $facts['os']['name'] ? {
		'Ubuntu'	=> 'xUbuntu',
		default		=> $facts['os']['name'],
	}
	$obs_os_release		= $facts['os']['name'] ? {
		'Debian'	=> "${facts['os']['release']['major']}.0",
		default		=> $facts['os']['release']['major'],
	}
	$repo_url		= "http://download.opensuse.org/repositories/home:/ubn:/singularity/${obs_os_name}_${obs_os_release}"
	$repo_gpgcheck		= true
	$repo_gpgkey		= 'http://build.opensuse.org/projects/home:ubn:singularity/public_key'
	$repo_gpgkey_id		= '2CB50B5F357B924430F4680582B1F0EF39E31E24'
	$package_ensure		= 'latest'
	$package_name		= $facts['os']['family'] ? {
		'Debian'	=> 'singularity-container',
		default		=> 'singularity',
	}

}
