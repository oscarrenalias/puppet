class mongodb(
  $package_name = $mongodb::params::package_name,
  $service_name = $mongodb::params::service_name,
  $service_enable = $mongodb::params::service_enable,
  $service_ensure = $mongodb::params::service_ensure,
  $service_manage = $mongodb::params::service_manage,  
) inherits mongodb::params
{
  class { "mongodb::install": } ->
  class { "mongodb::config": } ~>
  class { "mongodb::service": } ->
  Class["mongodb"]
}

#
# Wrapper class for the Puppet dashboard with default values
#
class mongodb::node
{
  require mongodb
}
