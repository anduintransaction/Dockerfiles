# Based on https://github.com/klaemo/docker-couchdb
FROM klaemo/couchdb:1.6.1
MAINTAINER ductamnguyen@anduintransact.com

RUN echo "deb http://http.debian.net/debian wheezy-backports main" >> /etc/apt/sources.list

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends \
    build-essential git rebar software-properties-common \
    python-software-properties supervisor gettext

# install plugins
RUN mkdir -p /usr/local/lib/couchdb/plugins && \
    git clone https://github.com/etrepum/couchperuser.git /usr/local/lib/couchdb/plugins/couchperuser &&\
    cd /usr/local/lib/couchdb/plugins/couchperuser && \
    make

##### nginx
# Install
RUN apt-get -y install nginx
RUN rm -rf /etc/nginx
ADD ./config/nginx /etc/nginx

##### supervisor
# Configure
RUN rm -rf /etc/supervisor
ADD ./config/supervisor /etc/supervisor

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./config/couchdb/local.ini /usr/local/etc/couchdb/local.ini.tmpl

# Overwrite the start_couch script with our own version that starts logrotate, couchdb and nginx
ADD ./start_couch /opt/start_couch

# Default command for container
CMD ["/opt/start_couch"]
