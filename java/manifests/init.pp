class java::params {
  $version = $operatingsystem ? {
   /(CentOS|RedHat|Fedora)/ => "1.7.0",
   /(Debian|Ubuntu)/ => "7"
  }
  $provider = "openjdk"
  $type = "jdk"
  $enable_browser_plugin = true

  $install_maven = false
  $maven_version = "3.0.4"

  case $operatingsystem {
    /(Ubuntu|Debian)/: {
      $java_package = "java-$version-$type"
      $browser_plugin_package = "icedtea-$version-plugin"
      $maven_package = "maven"
    }
    /(RedHat|CentOS|Fedora)/: {
      $java_package = $type ? {
        "jdk" => "java-$version-$provider-devel",
        default => "java-$version-$provider",
      }
      $browser_plugin_package = "icedtea-web"
      # CentOS does not have an RPM package for Maven
      $maven_package = undef
    }
    default: { fail("Operating system $operatingsystem not supported yet") }
  }
}

class java(
  $version = $java::params::version,
  $provider = $java::params::provider,
  $type = $java::params::type,
  $enable_browser_plugin = $java::params::enable_browser_plugin,
  $install_maven = $java::params::install_maven,
  $maven_version = $java::params::maven_version
) inherits java::params {

  package { "java":
    name => $java_package,
    ensure => "present",
  }

  if($enable_browser_plugin) {
    package { "java-browser-plugin":
      name => $browser_plugin_package,
      ensure => "present",
      require => Package["java"],
    }
  }

  class { 'java::dev_tools':
    require => Package["java"],
  }
}

class java::dev_tools inherits java {
  if($install_maven == true) {
    include java::maven
  }
}
