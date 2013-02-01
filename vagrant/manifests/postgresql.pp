#
# Sets up a postgresql database, for Vagrant VMs
#
class vagrant::postgresql {
  class { "postgresql::server":
    config_hash => {
      "listen_addresses" => "*",
      "ip_mask_deny_postgres_user" => "1.1.1.1/1",
      "ip_mask_allow_all_users" => "0.0.0.0/0",
      "manage_redhat_firewall" => true,
    }
  }
  
  postgresql::db { "database":
    user => "db_user",
    password => "db_password",
    grant => [ "all" ],
  }
  
  $pg_hba_conf_path = $operatingsystem ? {
    "CentOS" => "/var/lib/pgsql/data/pg_hba.conf",
    "Ubuntu" => "/var/lib/postgres/8.4/data/pg_hba.conf",
    default => fail("Unsupported OS: $operatingsystem"),
  }
}
