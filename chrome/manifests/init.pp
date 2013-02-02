class chrome(
  $type = "stable",
  $arch = "amd64",
) {
  require wget

  if($operatingsystem != "Ubuntu") {
    fail("Operating system $operatingsystem is not supported yet")
  }

  wget::download { "chrome-package-download":
    source => "https://dl.google.com/linux/direct/google-chrome-${type}_current_$arch.deb",
    target => "/tmp/chrome-$type-$arch.deb",
    notify => Exec["install-chrome"],
  }

  package { "chrome-deps":
    name => [ "libxss1", "libgconf2-4" ],
    ensure => "present",
  }

  exec { "install-chrome":
    command => "/usr/bin/dpkg -i /tmp/chrome-$type-$arch.deb",
    logoutput => on_failure,
    unless => "/usr/bin/dpkg-query -l google-chrome",
    require => Package["chrome-deps"],
  }

#  exec { "add-google-key":
#    command => "/usr/bin/wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -",
#    logoutput => on_failure,
#  }

#  exec { "add-google-repo":
#    command => "/bin/echo \"deb http://dl.google.com/linux/chrome/deb/ $type main\" >> /etc/apt/sources.list.d/google.list",
#    logoutput => on_failure,
#  }

#  exec { "/usr/bin/apt-get update": }

#  package { "google-chrome-$type":
#    ensure => "present",
#    require => [Exec["add-google-key"], Exec["add-google-repo"]],
#  }
}
