class nodejs::config inherits nodejs
{
  # link to the node installation
  file { "/usr/local/node":
    ensure => "link",
    target => "${node_home}",
    require => Class["nodejs::install"],
  }

  # create a linl to the node binary
  file { "/usr/local/bin/node":
    ensure => "link",
    target => "${node_home}/bin/node",
    require => Class["nodejs::install"],
  }
}
