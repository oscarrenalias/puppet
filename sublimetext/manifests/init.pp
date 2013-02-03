#
# Install Sublime Text using the webupd8 repos
#
class sublimetext(
  $version = "2.0.1",
  $target_folder = "/opt",
) {
  case $operatingsystem {
    /(Ubuntu|Debian|RedHat|Fedora|CentOS)/: {
      include sublimetext::install::linux
    }
    default: { fail("Operating system $operatingsystem is not supported yet") }
  }
}

class sublimetext::install::linux {
  include wget

  wget::download { "sublime-download":
    source => "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20${version}%20x64.tar.bz2",
    target => "/tmp/sublime-text-$version.tar.bz2",
    notify => Exec["sublime-text-untar"],
  }

  exec { "sublime-text-untar":
    command => "/bin/bzip2 -dc /tmp/sublime-text-$version.tar.bz2 | /bin/tar x -C $target_folder",
    logoutput => on_failure,
    unless => "/usr/bin/test -d \"/opt/Sublime Text 2\"",
    notify => File["/usr/local/bin/subl"],
  }

  file { "/usr/local/bin/subl":
    target => "/opt/Sublime Text 2/sublime_text",
    ensure => "link"
  }
}
