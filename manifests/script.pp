# Define profile::script
#
# This define creates a single script in /etc/rc.local/.d that is executed by /etc/rc.local at boot time
#
# Usage:
# profile::script { "set_route":
#   priority => "10",
#   content  => "route add -net 10.42.0.0/24 gw 10.42.10.1 \n",
# }
#
# Priority influences the execution order while content contains the script
# to be executed. Can be also a template, had has the saem syntax of the
# content param in the file type.
#
define profile::script (
  $priority = '50',
  $autoexec = true,
  $content  = '' ) {

  include profile
  require profile::params

  $safe_name = regsubst($name, '/', '_', 'G')
  $bool_autoexec = any2bool($autoexec)

  file { "profile_${priority}_${safe_name}":
    path    => "${profile::params::configdir}/${priority}-${safe_name}",
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    require => File['/etc/rc.local.d'],
    content => $content,
  }

  if $bool_autoexec == true {
    exec { "profile_${priority}_${safe_name}":
      command     => "sh ${profile::params::configdir}/${priority}-${safe_name}",
      refreshonly => true,
      subscribe   => File[ "profile_${priority}_${safe_name}" ],
      path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    }
  }
}

