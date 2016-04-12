# start rsync daemon on configurable directory

class rsbackup (
  $base = '/var/tmp'
  ){
  mount { $base:
    ensure  => mounted,
    device  => '/backups',
    fstype  => 'none',
    options => 'rw,bind',
    before  => Service['rsync'],
  }

  package { 'rsync':
    ensure => 'present',
    before => File['/etc/default/rsync','/etc/rsyncd.conf'],
  }

  file { '/etc/rsyncd.conf':
    ensure  => 'present',
    content => template('rsbackup/rsyncd.conf.erb'),
    notify  => Service['rsync'],
  }

  file { '/etc/default/rsync':
    ensure  => 'present',
    content => template('rsbackup/rsyncdefaults.erb'),
    notify  => Service['rsync'],
  }

  service { 'rsync':
    ensure    =>'running',
    enable    => true,
    subscribe => File['/etc/default/rsync','/etc/rsyncd.conf'],
  }

}
