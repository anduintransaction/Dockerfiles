FROM ubuntu:16.04
MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive
ENV SYNC_GATEWAY_VERSION 1.5.1

RUN apt-get -y update && \
    apt-get -y install wget curl && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget --quiet https://packages.couchbase.com/releases/couchbase-sync-gateway/${SYNC_GATEWAY_VERSION}/couchbase-sync-gateway-community_${SYNC_GATEWAY_VERSION}_x86_64.deb && \
    dpkg --unpack couchbase-sync-gateway-community_${SYNC_GATEWAY_VERSION}_x86_64.deb && \
    rm couchbase-sync-gateway-community_${SYNC_GATEWAY_VERSION}_x86_64.deb

ADD entrypoint.sh /opt/entrypoint.sh
ADD sync-gateway-config-default.json /opt/sync-gateway-config-default.json

ENTRYPOINT ["/opt/entrypoint.sh"]

CMD ["server"]
