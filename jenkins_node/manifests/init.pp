class jenkins_node {
  class { "jenkins_node::fonts": } ->
  class { "jenkins": } ->
  class { "jenkins_node::plugins":
    notify => Class["jenkins::service"],
  } ->
  class { "jenkins::tools": }
}

class jenkins::tools {
  package { "rake":
    provider => "gem",
    ensure => "installed",
  }
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

# Install the plugins that we need
class jenkins_node::plugins {
  jenkins::plugin { "dashboard-view": }
  jenkins::plugin { "build-pipeline-plugin": }
  jenkins::plugin { "git-client": }
  jenkins::plugin { "git": }
}
