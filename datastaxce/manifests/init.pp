#
# DataStax Cassandra Community Edition
#
class datastaxce(
	$package_name = $datastaxce::params::package_name,
	$service_name = $datastaxce::params::service_name,
	$service_ensure = $datastaxce::params::service_ensure,
	$listen_address = $datastaxce::params::listen_address,
	$rpc_address = $datastaxce::params::rpc_address
) inherits datastaxce::params {
	require java
	require datastaxce::install
	require datastaxce::config
	require datastaxce::service
}