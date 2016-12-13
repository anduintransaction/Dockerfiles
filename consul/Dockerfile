FROM ubuntu:14.04

MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND=noninteractive \
    CONSUL_VERSION=0.7.1

RUN apt-get update && apt-get install -y unzip wget && \
    wget https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip && \
    unzip consul_${CONSUL_VERSION}_linux_amd64.zip && \
    rm consul_${CONSUL_VERSION}_linux_amd64.zip && \
    mv consul /opt/consul && \
    wget https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_web_ui.zip && \
    unzip consul_${CONSUL_VERSION}_web_ui.zip -d /opt/consul-ui && \
    rm consul_${CONSUL_VERSION}_web_ui.zip

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD consul-config.json /opt/consul-config.json
EXPOSE 8500

VOLUME /data/consul

CMD exec /opt/consul agent -config-file=/opt/consul-config.json
