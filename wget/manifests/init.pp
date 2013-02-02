
class wget {
  package { "wget":
    ensure => "present",
  }
}

define wget::download($source, $target) {
  exec { "wget-$source-$target":
    command => "/usr/bin/wget $source -O $target",
    creates => $target,
    require => Package["wget"],
  }
}
