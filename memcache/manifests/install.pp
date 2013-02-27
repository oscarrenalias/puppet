class memcache::install inherits memcache
{
  package { $package_name:
    ensure => $package_ensure,
  }
}
