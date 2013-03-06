#
# Centos/RHEL specific configuration
#
class base::redhat inherits base {
  
}

#
# Enables the EPEL repository for RPM systems
#
class base::redhat::epel inherits base::redhat {
  # This was actually easier than doing it via the package type...
  exec { "install-epel":
    command => "/bin/rpm --replacepkgs http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm",
    unless => "/usr/bin/test -f /etc/yum.repos.d/epel.repo"
  }
}
