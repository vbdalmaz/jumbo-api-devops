exec { "apt-update":
    command => "/usr/bin/apt-get update"
}

package { ["openjdk-8-jre"]:
    ensure => installed,
    require => Exec["apt-update"]
}

file { "/home/ubuntu/jumbo.jar":
    source => "/vagrant/manifests/jumbo.jar",
    owner => "ubuntu",
    group => "ubuntu",
    mode => "0644",
    require => Package["openjdk-8-jre"]
}

exec { "docker-mongodb":
    command => "/usr/bin/docker run --name some-mongo -d -p 27017:27017 mongo"
}

exec { "run-api":
    command => "/usr/bin/java -jar /home/ubuntu/jumbo.jar &",
    require => Package["openjdk-8-jre"]
}