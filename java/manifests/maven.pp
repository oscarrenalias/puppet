class java::maven inherits java {
  case $operatingsystem {
    /(Ubuntu|Debian)/: {
      require java::maven::install::debian
    }
    /(RedHat|CentOS|Fedora)/: {
      require java::maven::install::redhat
    }
    default: {
      notice("$operatingsystem currently not supported")
    }
  }
}

class java::maven::install::debian inherits java::maven {
  package { $maven_package:
    ensure => "present",
  }
}

class java::maven::install::redhat inherits java::maven {
  $url = $maven_version ? {
    /^3\.*/ => "http://www.eu.apache.org/dist/maven/maven-3/${maven_version}/binaries/apache-maven-${maven_version}-bin.tar.gz",
    /^2\.*/ => "http://www.eu.apache.org/dist/maven/maven-2/${maven_version}/binaries/apache-maven-${maven_version}-bin.tar.gz"
  }
  
  wget::download { "maven-${maven_version}-download":
    source => $url,
    target => "/tmp/apache-maven-${maven_version}.tar.gz"
  }

  exec { "untar-maven":
    command => "/bin/tar zxvf /tmp/apache-maven-${maven_version}.tar.gz -C /opt",
    logoutput => on_failure,
    unless => "/usr/bin/test -d /opt/apache-maven-${maven_version}",
    require => Wget::Download["maven-${maven_version}-download"],
  }

  file { "maven-link":
    ensure => "link",
    target => "/opt/apache-maven-${maven_version}/bin/mvn",
    path => "/usr/bin/mvn",
    require => Exec["untar-maven"],
  }
}
