class datastaxce::params {
	$package_name = "dsc20"
	$service_name = "cassandra"
	$service_ensure = "running"

	# determine listen address, rpc address and seed nodes, or set to defaults
	# if not provided.
	$listen_address = $listen_address ? {
		"" => "0.0.0.0",
		default => $listen_address
	}

	$rpc_address = $rpc_address ? {
		"" => "0.0.0.0",
		default => $rpc_address
	}

	$seed_nodes = $seed_nodes ? {
		"" => $listen_address,
		default => $seed_nodes
	}
}