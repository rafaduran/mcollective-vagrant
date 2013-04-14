node default {
  if $::hostname =~ /^middleware/ {
     $role = "middleware"
  } else {
     $role = "node"
  }

  class{"roles::${role}": } ->

  file{'/root/.mc':
    ensure => directory,
  }

  file{"/root/.mc/${::hostname}-private.pem":
    source => "puppet:///modules/roles/keys/clients/${::hostname}-private.pem",
  }

  file{"/root/.mc/${::hostname}-public.pem":
    source => "puppet:///modules/roles/keys/clients/${::hostname}-public.pem",
  }

  file{'/etc/mcollective/ssl/clients':
    ensure  => directory,
    source  => 'puppet:///modules/roles/keys/clients',
    recurse => true,
    require => Class['mcollective'],
  }

  file{'/etc/mcollective/ssl/server-private.pem':
    source  => 'puppet:///modules/roles/keys/server-private.pem',
    require => Class['mcollective'],
  }

  file{'/etc/mcollective/ssl/server-public.pem':
    source  => 'puppet:///modules/roles/keys/server-public.pem',
    require => Class['mcollective'],
  }

  file{"/etc/mcollective/classes.txt":
    owner   => root,
    group   => root,
    mode    => 0444,
    content => inline_template("<%= classes.join('\n') %>"),
    require => Class['mcollective'],
  }

  host{"puppet":
    ip => "192.168.2.10"
  }
}
