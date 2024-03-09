# Install Nginx
package { 'nginx':
  ensure => installed,
}

# Define the custom HTTP header configuration file
file { '/etc/nginx/conf.d/custom_http_header.conf':
  ensure  => present,
  content => "server_tokens off;\nadd_header X-Served-By $::hostname;\n",
  notify  => Service['nginx'],
}

# Remove the default Nginx virtual host configuration
file { '/etc/nginx/sites-enabled/default':
  ensure => absent,
  notify => Service['nginx'],
}

# Restart Nginx service
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}

