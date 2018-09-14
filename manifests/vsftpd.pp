# class to install and configure vsftpd
#
class pitlinz_servicestools::vsftpd(
  $ensure             = present,
  $anonymous_enable   = 'NO',
  $local_enable       = 'YES',
  $write_enable       = 'YES',
  $async_abor_enable  = 'NO',
  $chroot_local_user  = 'YES',
  $pasv_enable        = 'YES',
  $pasv_min_port      = 62000,
  $pasv_max_port      = 62100,
  $pasv_address       = $::ipaddress,
) {

  if $ensure == present {
    $pkg_ensure = latest
    $serv_ensure = running
  } elsif $ensure == absent {
    $pkg_ensure = absent
    $serv_ensure = stopped
  }


  if !defined(Package['vsftpd']) {
    package{'vsftpd':
      ensure => $pkg_ensure
    }

    file{'/etc/vsftpd.conf':
      ensure  => $ensure,
      content => template('pitlinz_servicestools/vsftpd.conf.erb'),
      mode    => '0555',
      notify  => Service['vsftpd']
    }

    service{'vsftpd':
      ensure => $serv_ensure
    }

  }
}
