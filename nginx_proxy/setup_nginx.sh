#!/bin/bash

echo "Creating the password file."
sudo htpasswd -b -c /etc/user.pwd $HTTP_USER $HTTP_PASSWORD
echo "Password file is created."

echo "Starting nginx..."
/usr/sbin/nginx
