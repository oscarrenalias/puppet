class datastaxce::install inherits datastaxce {
	# [datastax] 
	# name = DataStax Repo for Apache Cassandra
	# baseurl = http://rpm.datastax.com/community
	# enabled=1
	# gpgcheck=0

	yumrepo { "datastax":
		name => "datastax",
		baseurl => "http://rpm.datastax.com/community",
		enabled => 1,
		gpgcheck => 0,
	}

	package { $package_name:
		ensure => "installed",
		require => Yumrepo["datastax"],
	}
}