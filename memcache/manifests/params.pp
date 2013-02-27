class memcache::params {
  # Package configuration
  $package_name = "memcached"
  $package_ensure = "installed"
  
  # Service configuration
  $service_name = "memcached"
  $service_enable = true
  $service_ensure = "running"
  $service_manage = true

  # default port - required by the firewall configuration
  $port = "11211"
}
