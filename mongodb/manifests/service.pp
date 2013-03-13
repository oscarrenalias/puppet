class mongodb::service inherits mongodb
{
    if($service_manage) {
      service { $service_name:
        ensure => $service_ensure,
        enable => $service_enable,
      }
    }
}
