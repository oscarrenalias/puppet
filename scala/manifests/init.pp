class scala(
  $include_typesafe_stack = true
) {
  if($include_typsafe_stack == true) {
    include scala::typesafe
  }

  package { "scala":
    ensure => "present",
  }
}


