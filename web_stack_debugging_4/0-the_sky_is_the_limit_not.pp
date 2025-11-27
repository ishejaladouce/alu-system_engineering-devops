# Fix Nginx to handle high concurrent traffic by increasing file descriptor limits
exec { 'fix--for-nginx':
  command => 'sed -i "s/15/4096/g" /etc/default/nginx && service nginx restart',
  path    => ['/usr/local/bin', '/bin', '/usr/bin', '/usr/sbin'],
}
