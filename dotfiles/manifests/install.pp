#
# Installs my own dotfiles repository for the given user
#
class dotfiles::install($user) inherits dotfiles {
  Exec { path => [ "/bin", "/usr/bin" ] }

  exec { "git-clone-dotfiles":
    command => "git clone $dotfiles_repo /home/${user}/dotfiles",
    # the base class installs git
    require => Class["base"],
    unless => "test -d /home/${user}/dotfiles", 
    notify => Exec["$user-dotfiles-run"],
    logoutput => on_failure,
  }

  file { "/home/${user}/dotfiles":
    owner => $user,
    recurse => true,
    require => Exec["git-clone-dotfiles"],
  }

  exec { "$user-dotfiles-run":
    command => "su $user -c 'env BATCH_MODE=1 /home/$user/dotfiles/bootstrap.sh'",
    cwd => "/home/${user}/dotfiles",
    logoutput => true,
  }
}
