class { 'postgresql::server': }

postgresql::server::role{'askbot':
  password_hash => 'askbot',
  superuser => true,
  login     => true,
  replication=> true,
}

postgresql::server::database_grant { 'askbot':
  privilege => 'ALL',
  db        => 'askbot',
  role      => 'askbot',
}