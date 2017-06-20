FROM ubuntu:16.04
MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
    apt-get -y install wget curl && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://github.com/anduintransaction/sync_gateway/releases/download/1.4.1-anduin/sync_gateway.tar.gz && \
    tar xvzf sync_gateway.tar.gz && \
    mv sync_gateway /opt && \
    rm sync_gateway.tar.gz

ADD entrypoint.sh /opt/entrypoint.sh
ADD sync-gateway-config-default.json /opt/sync-gateway-config-default.json

ENTRYPOINT ["/opt/entrypoint.sh"]

CMD ["/opt/sync-gateway-config-default.json"]
