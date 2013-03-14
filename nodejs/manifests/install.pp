class nodejs::install inherits nodejs
{
  wget::download { "nodejs-download":
    source => $download_link,
    target => "/tmp/node-$version.tar.gz",
  }

  exec { "unpack-node":
    command => "/bin/tar xvf /tmp/node-$version.tar.gz -C /usr/local",
    logoutput => on_failure,
    require => Wget::Download["nodejs-download"],
  }
}
