#
# DataStax Cassandra Community Edition
#


class datastaxce(
	$package_name = $datastaxce::params::package_name,
	$service_name = $datastaxce::params::service_name,
	$service_ensure = $datastaxce::params::service_ensure
) inherits datastaxce::params {
	require java
	require datastaxce::install
	require datastaxce::service
}