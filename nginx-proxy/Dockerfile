FROM nginx:1.11.8

MAINTAINER ductamnguyen@anduintransact.com

ADD proxy.conf.template /etc/nginx/conf.d/proxy.conf.template

ENV UPSTREAM '$host'

CMD /bin/bash -c "envsubst < /etc/nginx/conf.d/proxy.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
