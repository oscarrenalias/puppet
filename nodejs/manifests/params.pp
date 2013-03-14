class nodejs::params {
  # current newest version
  $version = "0.10.0"
  # Node's package naming is a bit weird, use either "x86" for 32-bit or "x64" for 64-bit
  $architecture = "x64"
  # target folder where node should be installed
  $install_folder = "/usr/local"
  # default firewall port to open
  $default_port = "8081"

  # download link (do not modify)
  $download_link = "http://nodejs.org/dist/v$version/node-v$version-linux-$architecture.tar.gz"
  # final folder where node will be installed, based on its version and architecture (do not modify)
  $node_home = "${install_folder}/node-v$version-linux-$architecture"
}
