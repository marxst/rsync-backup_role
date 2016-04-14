$rsbackup_hash    = hiera('rsync-backup_role',{})

class {'rsbackup':
  base => $rsbackup_hash['base']
}
