#increase file descriptor limits for the holberton user
exec { 'increase-holberton-limits':
  command => 'sed -i "s/holberton hard nofile 5/holberton hard nofile 5000/" /etc/security/limits.conf && sed -i "s/holberton soft nofile 4/holberton soft nofile 4000/" /etc/security/limits.conf && /sbin/sysctl -p',
  path    => '/usr/bin:/usr/sbin:/bin',
}
