# singularity

#### Table of Contents

1. [Description](#description)
1. [Usage](#usage)
1. [Limitations](#limitations)

## Description

This puppet module allows to install and configure [singularity](http://singularity.lbl.gov). It relies on the availability of the [Puppetlabs stdlib puppet module](https://github.com/puppetlabs/puppetlabs-stdlib). On Debian based operating systems it additionally requires the [Puppetlabs apt puppet module](https://github.com/puppetlabs/puppetlabs-apt).

Unless specified differently, it installs singularity from the [EPEL](https://fedoraproject.org/wiki/EPEL) repositories on RHEL systems. For Debian systems, you have to provide a repository by yourself.

It sets up the singularity configuration according to the provided settings.

## Usage

A minimal working example looks like this:

```puppet
class { '::singularity': }
```

An example with some custom settings is this:

```puppet
class { '::singularity':
    mount_tmp     => false,
    bind_path     => [
        {
            source      => '/etc/singularity/default-nsswitch.conf',
            destination => '/etc/nsswitch.conf',
        },
        '/opt',
        '/scratch',
    ],
    manage_repo   => true,
    repo_url      => 'http://yum.example.com/singularity',
    repo_gpgcheck => true,
    repo_gpgkey   => 'http://yum.example.com/singularity/RPM-GPG-KEY-singularity',
}
```
Allowed parameters are (descriptions are copied verbatim from the explanations in the [singularity.conf](https://github.com/singularityware/singularity/blob/master/etc/singularity.conf.in) file where applicable):

##### `allow_setuid`
Should we allow users to utilize the setuid binary for launching singularity? (default: yes)

##### `max_loop_devices`
Set the maximum number of loop devices that Singularity should ever attempt to utilize. (default: 256)

##### `allow_pid_ns`
Should we allow users to request the PID namespace? (default: yes)

##### `enable_overlay`
Enabling this option will make it possible to specify bind paths to locations that do not currently exist within the container. If 'try' is chosen, overlayfs will be tried but if it is unavailable it will be silently ignored.
If 'driver' is chosen, overlayfs is handled by the image driver. (default: try)

##### `enable_underlay`
Enabling this option will make it possible to specify bind paths to locations
that do not currently exist within the container even if overlay is not
working.  If overlay is available, it will be tried first. (default: yes)

##### `config_passwd`
If /etc/passwd exists within the container, this will automatically append an entry for the calling user. (default: yes)

##### `config_group`
If /etc/group exists within the container, this will automatically append an entry for the calling user. (default: yes)

##### `config_resolv_conf`
If there is a bind point within the container, use the host's /etc/resolv.conf. (default: yes)

##### `mount_proc`
Should we automatically bind mount /proc within the container? (default: yes)

##### `mount_sys`
Should we automatically bind mount /sys within the container? (default: yes)

##### `mount_dev`
Should we automatically bind mount /dev within the container? (default: yes)

##### `mount_home`
Should we automatically determine the calling user's home directory and attempt to mount it's base path into the container? (default: yes)

##### `mount_tmp`
Should we automatically bind mount /tmp and /var/tmp into the container? (default: yes)

##### `mount_hostfs`
Probe for all mounted file systems that are mounted on the host, and bind those into the container? (default: no)

##### `bind_path`
Define a list of files/directories that should be made available from within the container. (default: [ '/etc/localtime', '/etc/hosts' ])

##### `user_bind_control`
Allow users to influence and/or define bind points at runtime? (default: yes)

##### `enable_fusemount`
Allow users to mount fuse filesystems inside containers with the --fusemount command line option. (default: yes)

##### `mount_slave`
Should we automatically propagate file-system changes from the host? (default: yes)

##### `sessiondir_max_size`
This specifies how large the default sessiondir should be (in MB). (default: 16)

##### `limit_container_owners`
Only allow containers to be used that are owned by users in given array. (default: undef)

##### `limit_container_groups`
Only allow containers to be used that are owned by groups in given array. (default: undef)

##### `limit_container_paths`
Only allow containers to be used that are located within the given path prefix array. (default: undef)

##### `always_use_nv`
Always pass `--nv` option to Singularity implicitly.

##### `always_use_rocm`
Always pass `--rocm` option to Singularity implicitly.

##### `root_default_capabilities`
Define default root capability set kept during runtime. (default: full)

  - **full**: keep all capabilities (same as --keep-privs)|
  - **file**: keep capabilities configured in ${prefix}/etc/singularity/capabilities/user.root
  - **no**: no capabilities (same as --no-privs)

##### `memory_fs_type`
Chooses temporary filesystem used by Singularity.
Available options are `tmpfs` and `ramfs`.

##### `cni_config_path`
Defines path from where CNI configuration files are stored. (default: undef)

##### `cni_plugin_path`
Defines path from where CNI executable plugins are stored. (default: undef)

##### `mksquashfs_path`
This allows the administrator to specify the location for mksquashfs if it is not installed in a standard system location. (default: undef)

##### `mksquashfs_procs`
This allows the administrator to specify the number of CPUs for mksquashfs
to use when building an image. (default: 0, which corresponds to all CPUs)

##### `mksquashfs_mem`
This allows the administrator to set the maximum amount of memory for mkswapfs
to use when building an image.  e.g. 1G for 1gb or 500M for 500mb.
NOTE: This fuctionality did not exist in squashfs-tools prior to version 4.3
If using an earlier version you should not set this. (default: undef)

##### `cryptsetup_path`
This allows the administrator to specify the location for cryptsetup if it is not installed in a standard system location. (default: undef)

##### `shared_loop_devs`
Allow to share same images associated with loop devices to minimize loop
usage and optimize kernel cache (useful for MPI). (default: no)

##### `image_driver`
This option specifies the name of an image driver provided by a plugin that
will be used to handle image mounts. If the 'enable overlay' option is set
to 'driver' the driver name specified here will also be used to handle
overlay mounts.
If the driver name specified has not been registered via a plugin installation
the run-time will abort. (default: '')

##### `use_repo_urls`
Uses provided repository URLs (and gpgkey etc) instead of built-in default (EPEL for now only).

##### `manage_repo`
Should this module handle singularity repository setup? (default: true)

##### `repo_ensure`
Ensure singularity repository is either 'present' or 'absent'. (default: 'present')

##### `repo_url`
Use given repository URL. (default: undef)

##### `repo_gpgcheck`
Should we check GPG signature? (default: true)

##### `repo_gpgkey`
Verify using this GPG key. (default: undef)

##### `repo_gpgkey_id`
The ID of the GPG key (this is only used on Debian based operating systems) (default: undef)

##### `package_ensure`
Ensure particular package version. (default: 'latest')

##### `package_name`
Name of the singularity package (default: 'singularity-container' on Debian based operating systems, 'singularity' on other OSes)

## Limitations
 - At present this module only supports Redhat and Debian based operating systems.
 - None of the additional configuration files available with Singularity 3 are supported yet (cgroups, capabilities etc.).
