#!/usr/bin/env bash

envsubst '${NGINX_BASIC_AUTH} ${NGINX_PROXY}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

/usr/bin/supervisord --configuration /etc/supervisor/supervisord.conf
