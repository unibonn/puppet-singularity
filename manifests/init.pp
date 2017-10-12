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
	Boolean					$allow_setuid			= $singularity::params::allow_setuid,
	Integer					$max_loop_devices		= $singularity::params::max_loop_devices,
	Boolean					$allow_pid_ns			= $singularity::params::allow_pid_ns,
	Variant[Boolean, Enum['try']]		$enable_overlay			= $singularity::params::enable_overlay,
	Boolean					$config_passwd			= $singularity::params::config_passwd,
	Boolean					$config_group			= $singularity::params::config_group,
	Boolean					$config_resolv_conf		= $singularity::params::config_resolv_conf,
	Boolean					$mount_proc			= $singularity::params::mount_proc,
	Boolean					$mount_sys			= $singularity::params::mount_sys,
	Variant[Boolean, Enum['minimal']]	$mount_dev			= $singularity::params::mount_dev,
	Boolean					$mount_devpts			= $singularity::params::mount_devpts,
	Boolean					$mount_home			= $singularity::params::mount_home,
	Boolean					$mount_tmp			= $singularity::params::mount_tmp,
	Boolean					$mount_hostfs			= $singularity::params::mount_hostfs,
	Boolean					$user_bind_control		= $singularity::params::user_bind_control,
	Boolean					$mount_slave			= $singularity::params::mount_slave,
	Integer					$sessiondir_max_size		= $singularity::params::sessiondir_max_size,
	Optional[Array[String]]			$limit_container_owners		= $singularity::params::limit_container_owners,
	Optional[Array[Stdlib::Absolutepath]]	$limit_container_paths		= $singularity::params::limit_container_paths,
	Boolean					$allow_container_squashfs	= $singularity::params::allow_container_squashfs,
	Boolean					$allow_container_extfs		= $singularity::params::allow_container_extfs,
	Boolean					$allow_container_dir		= $singularity::params::allow_container_dir,
	Optional[Array[Stdlib::Absolutepath]]	$autofs_bug_path		= $singularity::params::autofs_bug_path,
	Optional[Array[Variant[Stdlib::Absolutepath, Hash[Enum['source', 'destination'], Stdlib::Absolutepath]]]]	$bind_path	= $singularity::params::bind_path,

	Boolean					$manage_repo		= $singularity::params::manage_repo,
	Enum['present', 'absent']		$repo_ensure		= $singularity::params::repo_ensure,
	String					$repo_url		= $singularity::params::repo_url,
	Boolean					$repo_gpgcheck		= $singularity::params::repo_gpgcheck,
	String					$repo_gpgkey		= $singularity::params::repo_gpgkey,
	Optional[String]			$repo_gpgkey_id		= $singularity::params::repo_gpgkey_id,
	String					$package_ensure		= $singularity::params::package_ensure,
	String					$package_name		= $singularity::params::package_name,
) inherits singularity::params {

	contain singularity::install
	contain singularity::config

	Class['::singularity::install']->
	Class['::singularity::config']

}
