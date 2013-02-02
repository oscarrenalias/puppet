class scala {
  case $operatingsystem {
    /(Ubuntu|Debian)/: {
      require scala::typesafe_repo::ubuntu
    }
    default: { fail("Operating system $operatingsystem not supported yet") }
  }

}

class scala::typesafe_repo::ubuntu {
  require wget
  
  wget::download { "typesafe.deb":
    source => "http://apt.typesafe.com/repo-deb-build-0002.deb",
    target => "/tmp/typesafe.deb",
  }

  exec { "add-typesafe-repo":
    command => "/usr/bin/dpkg -i /tmp/typesafe.deb && apt-get update",
    logoutput => on_failure,
    require => Wget::Download["typesafe.deb"],
    unless => "/bin/cat /etc/apt/sources.list.d/typesafe-apt.list"
  }

  package { "typesafe-stack":
    require => Exec["add-typesafe-repo"],
    ensure => "present",
  }
}
