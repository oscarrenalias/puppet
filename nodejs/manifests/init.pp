class nodejs(
  $version = $nodejs::params::version,
  $download_link = $nodejs::params::download_link,
  $install_folder = $nodejs::params::install_folder
) inherits nodejs::params
{
  class { "wget": } ->
  class { "nodejs::install": } ->
  class { "nodejs::config": } ~>
  class { "nodejs::service": } ->
  Class["nodejs"]
}

#
# Wrapper class for the Puppet dashboard with default values
#
class nodejs::node
{
  require nodejs
}
