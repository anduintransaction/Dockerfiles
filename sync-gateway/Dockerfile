FROM ubuntu:16.04
MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
    apt-get -y install wget curl

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://packages.couchbase.com/releases/couchbase-sync-gateway/1.4.1/couchbase-sync-gateway-community_1.4.1-3_x86_64.deb && \
    dpkg --unpack couchbase-sync-gateway-community_1.4.1-3_x86_64.deb

ADD entrypoint.sh /opt/entrypoint.sh
ADD sync-gateway-config-default.json /opt/sync-gateway-config-default.json

ENTRYPOINT ["/opt/entrypoint.sh"]

CMD ["/opt/sync-gateway-config-default.json"]
