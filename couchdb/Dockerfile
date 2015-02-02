# Based on https://github.com/klaemo/docker-couchdb
FROM anduin/base:0.3.1
MAINTAINER Binh Nguyen "binhnguyen@anduintransact.com"

RUN groupadd -r couchdb && useradd -d /var/lib/couchdb -g couchdb couchdb

RUN add-apt-repository ppa:couchdb/stable && \
    apt-get update -y \
  && apt-get install -y --no-install-recommends \
  couchdb rebar

RUN mkdir -p /usr/local/lib/couchdb/plugins && \
    chown -R couchdb:couchdb \
    /usr/local/lib/couchdb /usr/local/etc/couchdb \
    /usr/local/var/lib/couchdb /usr/local/var/log/couchdb /usr/local/var/run/couchdb \
  && chmod -R g+rw \
    /usr/local/lib/couchdb /usr/local/etc/couchdb \
    /usr/local/var/lib/couchdb /usr/local/var/log/couchdb /usr/local/var/run/couchdb \
  && mkdir -p /var/lib/couchdb

# install plugins
RUN git clone https://github.com/etrepum/couchperuser.git /usr/local/lib/couchdb/plugins \
    cd /usr/local/lib/couchdb/plugins \
    make \
    service couchdb restart

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose to the outside
RUN sed -e 's/^bind_address = .*$/bind_address = 0.0.0.0/' -i /usr/local/etc/couchdb/default.ini

COPY local.ini /usr/local/etc/couchdb/
COPY ./docker-entrypoint.sh /entrypoint.sh

# Define mountable directories.
VOLUME ["/usr/local/var/log/couchdb", "/usr/local/var/lib/couchdb"]

EXPOSE 5984
WORKDIR /var/lib/couchdb

ENTRYPOINT ["/entrypoint.sh"]
CMD ["couchdb"]
