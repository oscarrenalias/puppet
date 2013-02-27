#
# Centos/RHEL specific configuration
#
class base::redhat inherits base {
  
}

#
# Enables the EPEL repository for RPM systems
#
class base::redhat::epel inherits base::redhat {
  package { "epel":
    provider => "rpm",
    source => "http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm",
    ensure => "installed",
  }
}
