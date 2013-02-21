class grails(
  $version = "2.2.0"
) {
  case $operatingsystem {
    "Ubuntu": { require grails::install::ubuntu }
    default: { fail("Operating system $operatingsystem currently not supported") }
  }
}

class grails::install::ubuntu inherits grails {
  exec { "add-grails-apt-repository":
    command => "/usr/bin/add-apt-repository ppa:groovy-dev/grails && /usr/bin/apt-get update",
    unless => "/usr/bin/test -f /etc/apt/sources.list.d/groovy-dev*.list",
  }

  package { "grails-ppa":
    ensure => "present",
    require => Exec["add-grails-apt-repository"],
  }

  package { "grails":
    name => "grails-$version",
    ensure => "present",
    require => Package["grails-ppa"],
  }
}
