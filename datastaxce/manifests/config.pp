class datastaxce::config inherits datastaxce {
	file { "/etc/cassandra/default.conf/cassandra.yaml":
		content => template("datastaxce/etc/cassandra/default.conf/cassandra.yaml.erb"),
		ensure => "present",
		notify => Class["Datastaxce::Service"],
	}
}