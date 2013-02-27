class memcache(
  $package_name = $memcache::params::package_name,
  $service_name = $memcache::params::service_name,
  $service_enable = $memcache::params::service_enable,
  $service_ensure = $memcache::params::service_ensure,
  $service_manage = $memcache::params::service_manage,  
) inherits memcache::params
{
  case $operatingsystem {
    /(RedHat|Fedora|CentOS)/: { require base::redhat::epel }
    default: { fail("Support for $operatingsystem has not been implemented yet") }
  }
  
  class { "memcache::install": } ->
  class { "memcache::config": } ~>
  class { "memcache::service": } ->
  Class["memcache"]
}

#
# Wrapper class for the Puppet dashboard with default values
#
class memcache::node
{
  require memcache
}
