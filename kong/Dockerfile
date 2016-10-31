FROM anduin/consul-template-supervisor:1.1

MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive
ENV KONG_VERSION 0.9.2
ENV CONSUL_APP_CONFIG /etc/kong.conf

RUN apt-get update && \
    apt-get install -y netcat openssl libpcre3 dnsmasq procps perl postgresql-client && \
    wget https://github.com/Mashape/kong/releases/download/$KONG_VERSION/kong-$KONG_VERSION.trusty_all.deb && \
    dpkg -i kong-0.9.2.*.deb

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* kong-0.9.2.*.deb

RUN mkdir -p /data/kong

ADD run-consul.sh /opt
ADD run-kong.sh /opt
ADD supervisord.conf /etc/supervisord.conf

CMD /opt/run-consul.sh
