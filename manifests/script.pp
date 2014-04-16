# Define profile::script
#
# This define creates a single script in /etc/profile.d
#
define profile::script (
  $priority = '',
  $autoexec = false,
  $source   = '',
  $content  = '',
  $owner    = 'root',
  $group    = 'root',
  $mode     = '0755' ) {

  include profile
  require profile::params


  $safe_name = regsubst($name, '/', '_', 'G')
  $bool_autoexec = any2bool($autoexec)
  $manage_file_source = $source ? {
    ''        => undef,
    default   => $source,
  }
  $manage_file_content = $content ? {
    ''        => undef,
    default   => $content,
  }

  file { "profile_${priority}_${safe_name}":
    path    => "${profile::config_dir}/${priority}-${safe_name}.sh",
    mode    => $mode,
    owner   => $owner,
    group   => $group,
    content => $manage_file_content,
    source  => $manage_file_source,
    audit   => $profile::manage_audit,
  }

  if $bool_autoexec == true {
    exec { "profile_${priority}_${safe_name}":
      command     => "sh ${profile::config_dir}/${priority}-${safe_name}.sh",
      refreshonly => true,
      subscribe   => File[ "profile_${priority}_${safe_name}" ],
      path        => '/usr/bin:/bin:/usr/sbin:/sbin',
    }
  }
}

