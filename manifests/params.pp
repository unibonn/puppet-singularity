class singularity::params {

	if ! $facts['os']['family'] == 'RedHat' {
		fail("singularity: This module does not support OSes of family ${facts['os']['family']}")
	}

	$allow_setuid		= true
	$allow_pid_ns		= true
	$enable_overlay		= true
	$config_passwd		= true
	$config_group		= true
	$config_resolv_conf	= true
	$mount_proc		= true
	$mount_sys		= true
	$mount_dev		= true
	$mount_home		= true
	$mount_tmp		= true
	$mount_hostfs		= false
	$user_bind_control	= true
	$mount_slave		= true
	$container_dir		= '/var/singularity/mnt'
	$sessiondir_prefix	= '/tmp/.singularity-session-'
	$bind_path		= undef

	$manage_repo		= true
	$repo_ensure		= 'present'
	$repo_url		= "http://download.opensuse.org/repositories/home:/ubn:/singularity/${facts['os']['name']}_${facts['os']['release']['major']}"
	$repo_gpgcheck		= true
	$repo_gpgkey		= 'http://build.opensuse.org/projects/home:ubn:singularity/public_key'
	$package_ensure		= 'latest'

}
