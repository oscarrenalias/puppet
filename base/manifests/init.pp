#
# Colllection of things that I always install
#
class base(
  $enable_hibernate = true
) {
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

