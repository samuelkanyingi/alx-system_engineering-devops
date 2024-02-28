#Install Nginx web server (w/ Puppet)
# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Configure Nginx server
file { '/var/www/html/index.html':
  ensure  => present,
  content => 'Hello World!',
}
file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => "
server {
    listen 80;
    listen [::]:80;

    root /var/www/html;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location /redirect_me {
        return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
    }
}",
}

# Enable the default site
file { '/etc/nginx/sites-enabled/default':
  ensure => 'link',
  target => '/etc/nginx/sites-available/default',
}

# Restart Nginx service
service { 'nginx':
  ensure    => 'running',
  enable    => true,
  subscribe => File['/etc/nginx/sites-available/default'],
}
