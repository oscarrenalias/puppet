class mongodb::install inherits mongodb
{
  # set up the 10gen repo
  yumrepo { "10gen":
    name => "10gen-repository",
    baseurl => "http://downloads-distro.mongodb.org/repo/redhat/os/x86_64",
    gpgcheck => 0,
    enabled => 1,
  }

  package { $package_name:
    ensure => $package_ensure,
    require => Yumrepo["10gen"],
  }

  package { $tools_package_name:
    ensure => $package_ensure,
    require => Yumrepo["10gen"],
  }  
}
