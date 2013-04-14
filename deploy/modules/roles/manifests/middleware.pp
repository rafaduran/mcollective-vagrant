class roles::middleware {
  service{'iptables': ensure => stopped}

  class{'repos': } ->

  class{'java':
    distribution => 'jdk',
    version      => 'latest',
  } ->

  class{'activemq': }

  class{'puppet': } ->
  class{'nagios': } ->
  class{'puppet::master': } ->
  class{'mcollective': } ->
  class{'motd': } ->
  Class[$name]

  exec{'/usr/bin/curl http://srt.ly/mcvagrantcounter':
    refreshonly => true,
    subscribe => Class['motd']
  }
}
