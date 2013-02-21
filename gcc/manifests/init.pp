class gcc(
  $ensure = "present"
) {
  $package_name = $operatingsystem ? {
    default => "gcc"
  }

  package { $package_name:
    ensure => $ensure
  }
}
