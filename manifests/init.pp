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
	Variant[Boolean, Enum['try', 'driver']]	$enable_overlay			= $singularity::params::enable_overlay,
	Boolean					$enable_underlay		= $singularity::params::enable_underlay,
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
	Optional[Array[Variant[Stdlib::Absolutepath, Hash[Enum['source', 'destination'], Stdlib::Absolutepath]]]]	$bind_path	= $singularity::params::bind_path,
	Boolean					$user_bind_control		= $singularity::params::user_bind_control,
	Boolean					$enable_fusemount		= $singularity::params::enable_fusemount,
	Boolean					$mount_slave			= $singularity::params::mount_slave,
	Integer					$sessiondir_max_size		= $singularity::params::sessiondir_max_size,
	Optional[Array[String]]			$limit_container_owners		= $singularity::params::limit_container_owners,
	Optional[Array[String]]			$limit_container_groups		= $singularity::params::limit_container_groups,
	Optional[Array[Stdlib::Absolutepath]]	$limit_container_paths		= $singularity::params::limit_container_paths,
	Boolean					$allow_container_squashfs	= $singularity::params::allow_container_squashfs,
	Boolean					$allow_container_extfs		= $singularity::params::allow_container_extfs,
	Boolean					$allow_container_dir		= $singularity::params::allow_container_dir,
	Boolean					$allow_container_encrypted	= $singularity::params::allow_container_encrypted,
	Optional[Array[String]]			$allow_net_users		= $singularity::params::allow_net_users,
	Optional[Array[String]]			$allow_net_groups		= $singularity::params::allow_net_groups,
	Optional[Array[String]]			$allow_net_networks		= $singularity::params::allow_net_networks,
	Boolean					$always_use_nv			= $singularity::params::always_use_nv,
	Boolean					$always_use_rocm		= $singularity::params::always_use_rocm,
	Enum['full','file','no']		$root_default_capabilities	= $singularity::params::root_default_capabilities,
	Enum['tmpfs', 'ramfs']			$memory_fs_type			= $singularity::params::memory_fs_type,
	Optional[String]			$cni_config_path		= $singularity::params::cni_config_path,
	Optional[String]			$cni_plugin_path		= $singularity::params::cni_plugin_path,
	Optional[String]			$mksquashfs_path		= $singularity::params::mksquashfs_path,
	Integer					$mksquashfs_procs		= $singularity::params::mksquashfs_procs,
	Optional[String]			$mksquashfs_mem			= $singularity::params::mksquashfs_mem,
	Optional[String]			$cryptsetup_path		= $singularity::params::cryptsetup_path,
	Boolean					$shared_loop_devs		= $singularity::params::shared_loop_devs,
	String					$image_driver			= $singularity::params::image_driver,

	Boolean					$use_repo_urls		= $singularity::params::use_repo_urls,
	Boolean					$manage_repo		= $singularity::params::manage_repo,
	Enum['present', 'absent']		$repo_ensure		= $singularity::params::repo_ensure,
	Optional[String]			$repo_url		= $singularity::params::repo_url,
	Boolean					$repo_gpgcheck		= $singularity::params::repo_gpgcheck,
	Optional[String]			$repo_gpgkey		= $singularity::params::repo_gpgkey,
	Optional[String]			$repo_gpgkey_id		= $singularity::params::repo_gpgkey_id,
	String					$package_ensure		= $singularity::params::package_ensure,
	String					$package_name		= $singularity::params::package_name,
) inherits singularity::params {

	contain singularity::install
	contain singularity::config

	Class['::singularity::install']->
	Class['::singularity::config']

}
