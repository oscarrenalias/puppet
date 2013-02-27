class memcache::service inherits memcache
{
    if($service_manage) {
      service { $service_name:
        ensure => $service_ensure,
        enable => $service_enable,
      }
    }
    else {
      notice("Service not started as per the configuration")
    }
}
