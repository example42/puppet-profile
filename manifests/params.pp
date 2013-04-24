# Class: profile::params
#
# Sets internal variables and defaults for profile module
# This class is automatically loaded in all the classes that use the values set here 
#
class profile::params  {

## MODULE INTERNAL VARIABLES
# (Modify to adapt to unsupported OSes)

  $configfile = $::osfamily ? {
    RedHat  => '/etc/rc.d/rc.local',
    default => '/etc/rc.local',
  }

  $configdir = $::operatingsystem ? {
    default => '/etc/rc.local.d',
  }
}
