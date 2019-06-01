class singularity::params {

	if ! $facts['os']['family'] == 'RedHat' and ! $facts['os']['family'] == 'Debian' {
		fail("singularity: This module does not support OSes of family ${facts['os']['family']}")
	}

	$allow_setuid			= true
	$max_loop_devices		= 256
	$allow_pid_ns			= true
	$enable_overlay			= 'try'
	$enable_underlay		= true
	$config_passwd			= true
	$config_group			= true
	$config_resolv_conf		= true
	$mount_proc			= true
	$mount_sys			= true
	$mount_dev			= true
	$mount_devpts			= true
	$mount_home			= true
	$mount_tmp			= true
	$mount_hostfs			= false
	$user_bind_control		= true
	$mount_slave			= true
	$sessiondir_max_size		= 16
	$bind_path			= [ '/etc/localtime', '/etc/hosts' ]
	$limit_container_owners		= undef
	$limit_container_groups		= undef
	$limit_container_paths		= undef
	$allow_container_squashfs	= true
	$allow_container_extfs		= true
	$allow_container_dir		= true
	$autofs_bug_path		= [ ]
	$memory_fs_type			= 'tmpfs'
	$always_use_nv			= false
	$shared_loop_devs		= false

	$use_repo_urls		= false
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
	$repo_url		= undef
	$repo_gpgcheck		= true
	$repo_gpgkey		= undef
	$repo_gpgkey_id		= undef
	$package_ensure		= 'latest'
	$package_name		= $facts['os']['family'] ? {
		'Debian'	=> 'singularity-container',
		default		=> 'singularity',
	}

}
