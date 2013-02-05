class base::ubuntu inherits base {
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

  # delete the shopping lens that is part of 12.10 (and likely onwards)
  case $operatingsystemrelease {
    "12.10": {
      package { "unity-lens-shopping":
        ensure => "absent",
      }
    }
  }

  # enable hibernate
  if($enable_hibernate) {
    file { "hibernate-policy-file":
      path => "/etc/polkit-1/localauthority/50-local.d/com.ubuntu.enable-hibernate.pkla",
      content => template("base/com.ubuntu.enable-hibernate.pkla.erb"),
      ensure => "present",
    }
  }
}
