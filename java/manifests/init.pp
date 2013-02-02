class java(
  $version = "7",
  $provider = "openjdk",
  $type = "jdk",
  $enable_browser_plugin = true,
  $install_dev_tools = false,
) {

  case $operatingsystem {
    /(Ubuntu|Debian)/: {
      $package = "$provider-$version-$type"
      $browser_plugin_package = "icedtea-$version-plugin"
    }
    default: { fail("Operating system $operatingsystem not supported yet") }
  }

  package { "java":
    name => $package,
    ensure => "present",
  }

  if($enable_browser_plugin) {
    package { "java-browser-plugin":
      name => $browser_plugin_package,
      ensure => "present",
      require => Package["java"],
    }
  }

  if($install_dev_tools == true) {
    class { 'java::dev_tools':
      require => Package["java"],
    }
  }
}

class java::dev_tools inherits java {
  include java::maven
}

class java::maven inherits java {
  package { "maven":
    ensure => "present",
  }
}
