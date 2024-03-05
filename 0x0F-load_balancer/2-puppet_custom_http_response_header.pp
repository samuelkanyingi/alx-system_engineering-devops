tom_http_response_header.pp

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Define custom Nginx configuration file
file { '/etc/nginx/conf.d/custom_headers.conf':
  ensure  => present,
  content => "server {\n\tlocation / {\n\t\tadd_header X-Served-By $hostname;\n\t}\n}",
  notify  => Service['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure => running,
  enable => true,
}

