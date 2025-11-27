# Fix Nginx to handle high concurrent traffic by increasing file descriptor limits
exec { 'fix--for-nginx':
  command => 'sed -i "s/8080/80/g" /etc/nginx/sites-enabled/default',
  path    => ['/usr/local/bin', '/bin', '/usr/bin', '/usr/sbin'],
}

exec { 'increase-ulimit':
  command => 'sed -i "s/#ULIMIT=\"-n 4096\"/ULIMIT=\"-n 4096\"/g" /etc/default/nginx',
  path    => ['/usr/local/bin', '/bin', '/usr/bin', '/usr/sbin'],
}

exec { 'restart-nginx':
  command => 'service nginx restart',
  path    => ['/usr/local/bin', '/bin', '/usr/bin', '/usr/sbin'],
  require => [Exec['fix--for-nginx'], Exec['increase-ulimit']],
}
