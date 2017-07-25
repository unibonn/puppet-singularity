class singularity::config {

	$conf_file_ensure = $::singularity::package_ensure ? {
		'absent'	=> 'absent',
		default		=> 'file',
	}

	file { '/etc/singularity/singularity.conf':
		ensure		=> $conf_file_ensure,
		content		=> template('singularity/singularity.conf.erb'),
		owner		=> root,
		group		=> root,
		mode		=> '0644',
	}

}
