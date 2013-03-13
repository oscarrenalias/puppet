class mongodb::params {
  # Package configuration
  $package_name = "mongo-10gen-server"
  $tools_package_name = "mongo-10gen"
  $package_ensure = "installed"
  
  # Service configuration
  $service_name = "mongod"
  $service_enable = true
  $service_ensure = "running"
  $service_manage = true
}
