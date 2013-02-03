#
# Comment/uncomment the needed modules and then run:
#
# puppet apply --moduledir=`pwd` apply install.pp
#

require base
require chrome
require encfs
require dropbox

class { 'java':
  enable_browser_plugin => true,
  install_dev_tools => true,
}

require sublimetext
require scala
