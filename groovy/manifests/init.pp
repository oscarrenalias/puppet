class groovy(
  $version = "1.8.6"
) {

  $package = $operatingsystem ? {
    /(RedHat|CentOS|Fedora)/ => "groovy-${version}",
    /(Ubuntu|Debian)/ => "groovy ${version}",
    default => fail("Operating system ${operatingsystem} is currently not supported by this module"),
  }

  package { $package:
    ensure => "present",
  }
}
