class base::debian inherits base {
  exec{ "apt-get-update":
    command => "apt-get update",
    path => [ "/usr/bin/" ],
  }
}
