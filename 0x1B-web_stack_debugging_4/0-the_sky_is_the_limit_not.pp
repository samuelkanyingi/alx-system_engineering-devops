# Increase the limit for open file descriptors
exec { 'Increase Nginx ULIMIT':
  command => 'sed -i "s/ULIMIT=\"-n 15\"/ULIMIT=\"-n 5000\"/g" /etc/default/nginx',
  path    => ['/usr/bin', '/usr/sbin', '/bin'],
  notify  => Exec['Restart Nginx Service'],
}

# Restart Nginx service
exec { 'Restart Nginx Service':
  command     => '/usr/sbin/service nginx restart',
  refreshonly => true,
}
