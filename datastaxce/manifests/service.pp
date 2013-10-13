class datastaxce::service inherits datastaxce {
	service { $service_name:
		ensure => $service_ensure,
	}
}