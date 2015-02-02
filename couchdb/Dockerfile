# Based on https://github.com/klaemo/docker-couchdb
FROM klaemo/couchdb
MAINTAINER Binh Nguyen "binhnguyen@anduintransact.com"

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends \
    build-essential git

# install plugins
RUN mkdir -p /usr/local/lib/couchdb/plugins && \
    git clone https://github.com/etrepum/couchperuser.git /usr/local/lib/couchdb/plugins &&\
    cd /usr/local/lib/couchdb/plugins &&\
    make &&\
    start couchdb

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY local.ini /usr/local/etc/couchdb/
