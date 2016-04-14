$nodes_hash = hiera('nodes')

$rsyncnode = filter_nodes($nodes_hash,'role','rsync-backup_role')

$rsyncnodename = $::rsyncnode[0]['fqdn']
cron { 'rsync-backup':
  command => "/usr/bin/rsync -az /etc ${rsyncnodename}::backup/$(hostname)/",
  user    => 'root',
  hour    => 2,
  minute  => 0,
  }
