#
# Installs and configures my own attempt at dotfiles
#
class dotfiles(
  $dotfiles_repo = $dotfiles::params::dotfiles_repo
) inherits dotfiles::params
{
  class { "dotfiles::install":
    user => "vagrant",
  }
}
