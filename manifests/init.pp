# Class: singularity
# ==================
#
# Puppet module to install and configure Singularity (http://singularity.lbl.gov)
#
# For more information have a look at the README.md file.
#
# Authors
# -------
#
# Peter Wienemann <wienemann@physik.uni-bonn.de>
#
# Copyright
# ---------
#
# Copyright 2017 University of Bonn
#
class singularity(
	Boolean				$allow_setuid		= $singularity::params::allow_setuid,
	Boolean				$allow_pid_ns		= $singularity::params::allow_pid_ns,
	Boolean				$enable_overlay		= $singularity::params::enable_overlay,
	Boolean				$config_passwd		= $singularity::params::config_passwd,
	Boolean				$config_group		= $singularity::params::config_group,
	Boolean				$config_resolv_conf	= $singularity::params::config_resolv_conf,
	Boolean				$mount_proc		= $singularity::params::mount_proc,
	Boolean				$mount_sys		= $singularity::params::mount_sys,
	Boolean				$mount_dev		= $singularity::params::mount_dev,
	Boolean				$mount_home		= $singularity::params::mount_home,
	Boolean				$mount_tmp		= $singularity::params::mount_tmp,
	Boolean				$mount_hostfs		= $singularity::params::mount_hostfs,
	Boolean				$user_bind_control	= $singularity::params::user_bind_control,
	Boolean				$mount_slave		= $singularity::params::mount_slave,
	Stdlib::Absolutepath		$container_dir		= $singularity::params::container_dir,
	Stdlib::Absolutepath		$sessiondir_prefix	= $singularity::params::sessiondir_prefix,
	Optional[Array[Variant[Stdlib::Absolutepath, Hash[Enum['source', 'destination'], Stdlib::Absolutepath]]]]	$bind_path	= $singularity::params::bind_path,

	Boolean				$manage_repo		= $singularity::params::manage_repo,
	Enum['present', 'absent']	$repo_ensure		= $singularity::params::repo_ensure,
	String				$repo_url		= $singularity::params::repo_url,
	Boolean				$repo_gpgcheck		= $singularity::params::repo_gpgcheck,
	String				$repo_gpgkey		= $singularity::params::repo_gpgkey,
	String				$package_ensure		= $singularity::params::package_ensure,
) inherits singularity::params {

	contain singularity::install
	contain singularity::config

	Class['::singularity::install']->
	Class['::singularity::config']

}
