FROM ubuntu:14.04
MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com C300EE8C && \
    apt-get -y update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:nginx/stable && \
    apt-get -y update && \
    apt-get -y install nginx supervisor wget ca-certificates unzip curl

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV CONSUL_TEMPLATE_VERSION 0.16.0
RUN wget -O consul-template.zip https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip \
    && unzip consul-template.zip \
    && mv consul-template /usr/local/bin \
    && rm -rf consul-template.zip

RUN wget https://packages.couchbase.com/releases/couchbase-sync-gateway/1.4.0/couchbase-sync-gateway-community_1.4.0-2_x86_64.deb && \
    dpkg --unpack couchbase-sync-gateway-community_1.4.0-2_x86_64.deb

ENV SYNC_GATEWAY_CONFIG_FILE /opt/sync-gateway-config.json

RUN rm -rf /etc/nginx
ADD ./config/nginx /etc/nginx
ADD ./config/supervisord/supervisord.conf /opt
ADD ./run-sync-gateway.sh /opt
ADD ./run-consul.sh /opt

CMD exec supervisord -c /opt/supervisord.conf
