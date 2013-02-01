#
# Colllection of things that I always install
#
class base {
  package { "git":
    ensure => "present",
  }
  
  # this is not available in OS X
  case $operatingsystem {
    "Ubuntu": {
      package { "emacs24-nox":
        ensure => "present",
      }
    }
    /(CentOS|RedHat)/: {
      package { "emacs-nox":
	ensure => "present",
      }
    }
  }
  
  case $operatingsystem {
    /(CentOS|RedHat)/: { include base::redhat }
    "Ubuntu": { include base::ubuntu }
    "Darwin": { include base::darwin }
    default: { fail("Unsupported OS: $operatingsystem") }
  }        
}

class base::ubuntu {
  exec{ "apt-get-update":
    command => "apt-get update",
    path => [ "/usr/bin/" ],
    before => Package["language-pack-id"],
  }
  
  package { "language-pack-id":
    ensure => "present",
  }
  
  exec { "dpkg-reconfigure-locales":
    command => "dpkg-reconfigure locales",
    path => [ "/usr/sbin", "/usr/bin", "/bin", "/sbin" ],
    logoutput => on_failure,
    require => Package["language-pack-id"],
  }
}

#
# Centos/RHEL specific configuration
#
class base::redhat {
  
}

#
# OS X specific configuration
#
class base::darwin {

}
