class dropbox {
  case $operatingsystem {
    /(Ubuntu|Debian)/: { include dropbox::ubuntu }
    default: { fail("Operating system $operatingsystem not supported yet") }
  }
}

class dropbox::ubuntu inherits dropbox {
  Exec { path => ["/bin", "/usr/bin"], logoutput => on_failure }
  
  exec { "add-dropbox-apt-key":
    command => "apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E",
    unless => "apt-key list | grep -i Dropbox",
  }

  exec { "add-dropbox-apt-repo":
    # Even in 12.10 we have to use precise (12.04) instead of quatzal
    command => "add-apt-repository \"deb http://linux.dropbox.com/ubuntu precise main\"",
    unless => "grep dropbox /etc/apt/sources.list",
  }

  exec { "dropbox-apt-get-update":
    command => "apt-get update",
    require => [Exec["add-dropbox-apt-key"], Exec["add-dropbox-apt-repo"]]
  }

  package { "dropbox":
    ensure => "present",
    require => Exec["dropbox-apt-get-update"],
  }
}  
