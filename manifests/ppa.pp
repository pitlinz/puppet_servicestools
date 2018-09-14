# install a ppa package
define pitlinz_servicestools::ppa(
  $ppaname = undef,
  $ensure  = latest,
) {
  if !defined(Package['software-properties-common']) {
    package{'software-properties-common':
      ensure => latest
    }
  }

  if !defined(Package['python-software-properties']) {
    package{'python-software-properties':
      ensure => latest
    }
  }

  exec{"add-apt-repository $name":
    command => "/usr/bin/add-apt-repository ppa:${ppaname}",
    notify  => Exec["apt-update-ppa ${ppaname}"],
    unless  => "/usr/bin/apt-cache search python-certbot-apache |  /bin/grep -c \"^$name \"",
  }

  exec{"apt-update-ppa ${ppaname}":
    command     => '/usr/bin/apt-get update',
    refreshonly => true,
    before      => Package[$name]
  }

  package{$name:
    ensure    => latest,
    require   => Exec["add-apt-repository $name"]
  }


}
