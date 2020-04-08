# class to install mariadb server
class pitlinz_servicestools::mariadb(
    $ensure     = running,
    $serverid   = 10
) {

    package{'mariadb-server':
        ensure => latest
    }

    service{'mariadb':
        ensure => $ensure
    }
}
