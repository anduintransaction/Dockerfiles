# based on https://github.com/arun-gupta/docker-images/tree/master/couchbase-server

FROM couchbase/server:community
MAINTAINER Binh Nguyen "binhnguyen@anduintransact.com"

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends \
    build-essential git rebar software-properties-common \
    python-software-properties supervisor
    
##### supervisor
# Configure
RUN rm -rf /etc/supervisor
ADD ./config/supervisord /etc/supervisor

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY configure-node.sh /opt/anduin/couchbase/

CMD ["/opt/anduin/couchbase/configure-node.sh"]