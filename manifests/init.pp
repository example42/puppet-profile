# Class: profile
#
# Manages /etc/rc.local file inserting a /etc/rc.local.d/ directory where
# each script is managaed by Puppet
#
# Usage:
# include profile
#
class profile {

  # Load the variables used in this module. Check the params.pp file 
  require profile::params

  file { '/etc/rc.local':
    ensure  => present,
    path    => $profile::params::configfile,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    content => template('profile/rc.local.erb'),
  }

  file { '/etc/rc.local.d':
    path    => $profile::params::configdir,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    ensure  => directory,
    purge   => true,
    recurse => true,
  }
  
}
