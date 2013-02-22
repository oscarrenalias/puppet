class jenkins_node {
  class { "jenkins_node::fonts": } ->
  class { "jenkins": }
}

class jenkins_node::fonts {
  $font_package = $operatingsystem ? {
    /(Debian|Ubuntu)/ => "ttf-dejavu",
    /(RedHat|CentOS|Fedora)/ => "dejavu-sans-fonts",
  }

  package { $font_package:
    ensure => "installed"
  }
}
