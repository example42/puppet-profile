# Puppet module: profile

This is a Puppet module for to manage /etc/profile and /etc/profile.d
It provides only package installation and file configuration.

Based on Example42 layouts by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-profile

Released under the terms of Apache 2 License.

This module requires the presence of Example42 Puppi module in your modulepath.


## USAGE - Basic management

* Enable auditing without without making changes on existing profile configuration files

        class { 'profile':
          audit_only => true
        }

* Use custom sources for /etc/profile

        class { 'profile':
          source => [ "puppet:///modules/example42/profile/profile.conf-${hostname}" , "puppet:///modules/example42/profile/profile.conf" ], 
        }

* Place a custom script (using source) in /etc/profile.d/
  This creates the (executable) file: /etc/profile.d/java.sh

        profile::script { 'java':
          source => 'puppet:///modules/example42/profile/java.sh',
        }

* Place a custom script (using content) in /etc/profile.d/

        profile::script { 'java':
          content => template('/example42/profile/java.sh'),
        }

* Use custom source directory for the whole /etc/profile.d dir

        class { 'profile':
          source_dir       => 'puppet:///modules/example42/profile/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for /etc/profile. Note that template and source arguments are alternative. 

        class { 'profile':
          template => 'example42/profile/profile.conf.erb',
        }

* Automatically include a custom subclass

        class { 'profile':
          my_class => 'example42::my_profile',
        }

* Remove profile resources (DO NOT DO THAT)

        class { 'profile':
          absent => true
        }

[![Build Status](https://travis-ci.org/example42/puppet-profile.png?branch=master)](https://travis-ci.org/example42/puppet-profile)

