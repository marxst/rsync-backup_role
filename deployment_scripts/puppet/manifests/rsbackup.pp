$rsbackup_hash    = hiera('rsync-backup_role',{})

class {'rsbackup':
  base => $rsbackup_hash['base']
}

class {'::firewall':}

firewall {'837 rsync':
  port   => 837,
  proto  => 'tcp',
  action => 'accept',
}

