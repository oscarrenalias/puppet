#
# Enables EncFS encrypted filesystems
#
class encfs(
  $enable_cryptkeeper = false
) {
  case $operatingsystem {
    /(Ubuntu|Debian)/: { $package_name = "encfs" }
    /(CentOS|RedHat|Fedora)/: { $package_name = "fuse-encfs" }
    default: { fail("Operating system $operatingsystem not supported yet") }
  }

  package { $package_name:
    ensure => "present",
  }

  if($enable_cryptkeeper == true) {
    package { "cryptkeeper":
      ensure => "present",
      require => Package[$package_name],
    }
  }
}
