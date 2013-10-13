class datastaxce::params {
	$package_name = "dsc20"
	$service_name = "cassandra"
	$service_ensure = "running"

	# listen address and RPC address; for development purposes, "0.0.0.0" is good enough
	$listen_address = "0.0.0.0"
	$rpc_address = "0.0.0.0"
}