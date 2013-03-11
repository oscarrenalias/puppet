#
# Installs and configures my own attempt at dotfiles
#
class dotfiles(
  $dotfiles_repo = $dotfiles::params::dotfiles_repo,
  $user
) inherits dotfiles::params
{
  class { "dotfiles::install":
    user => $user,
  }
}

class dotfiles::vagrant {
  class { "dotfiles":
    user => "vagrant",
  }
}

class dotfiles::oscar {
  class { "dotfiles":
    user => "oscar",
  }
}