# install and manage ntp-service
class pitlinz_servicestools::ntp(

) {
    if !defined(Package['ntp']) {
        package{'ntp':
            ensure => latest
        }
    }

    if !defined(Service['ntp']) {
        service{'ntp':
            ensure => running
        }
    }
}
