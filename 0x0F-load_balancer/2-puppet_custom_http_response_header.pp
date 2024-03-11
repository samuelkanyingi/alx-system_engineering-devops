# Automate the task of creating a custom HTTP header response
# with Puppet
exec { 'update':
        command => '/usr/bin/apt-get update',
}

package { 'nginx':
	ensure => 'installed',
	require => Exec['update']
}

file {'/var/www/html/index.html':
	content => 'Hello there!'
}

exec {'redirect_me':
	command => 'sed -i "24i\	rewrite ^/redirect_me https://samservices.tech/  permanent;" /etc/nginx/sites-available/default',
	provider => 'shell'
}

exec {'HTTP header':
	command => 'sed -i "25i\	add_header X-Served-By \$hostname;" /etc/nginx/sites-available/default',
	provider => 'shell'
}

service {'nginx':
	ensure => running,
	require => Package['nginx']
}
