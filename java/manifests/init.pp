class java(
  $version = "7",
  $provider = "openjdk",
  $type = "jdk"
) {

  $package = $operatingsystem ? {
    /(Ubuntu|Debian)/ => "$provider-$version-$type",
    default => fail("Operating system $operatingsystem not supported yet")
  }
  
  package { "java":
    name => $package,
    ensure => "present",
  }
}
