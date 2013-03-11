class base::pi {
      user { "oscar":
      	   ensure => "present",
      }

      ssh_authorized_key { "oscar-ssh-key":
      		key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQC9posP04r8Df3HFYt5YPuesAsYT5ADj6BZx8SoJHm0P1rpi8STKKzFcVPYEDe0dFPs1Zq21acXZXGZ2U3UxtTQI3Qa2RD4XHw2UcpEoTOtPQMINd/0zeISk7nG31Ir0q+/YD0vy7N9fE0QasT1EJ76l+NIotoH9k/Gv8BwijLLQaIH/mzkNNoFgf4bY+LwwG9qoqxsqJetESHSczUOfyZmEg26m8RQzgdOgYBfciLhHUsBBbf0GjJdbfvHve3cskp8/z8Fw1PiUZGz1td2SghvSrDEgAx2/XvWTw/Lk+/zpp7tKCeRYmKq+XigSJaL2tKA5tGYvVVNVwX3Y91kXhd9",
		user => "oscar",
		ensure => "present",
		type => "rsa",
      }

      file { "/etc/sudoers.d/pi_config":
      	   ensure => "present",
	   content => template("base/pi/etc/sudoers.d/pi_config.erb"),
      }
}