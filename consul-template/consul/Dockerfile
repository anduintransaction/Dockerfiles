FROM ubuntu:14.04

MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND=noninteractive \
    CONSUL_VERSION=0.7.0-rc2

RUN apt-get update && apt-get install -y unzip wget && \
    wget https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip && \
    unzip consul_${CONSUL_VERSION}_linux_amd64.zip && \
    rm consul_${CONSUL_VERSION}_linux_amd64.zip && \
    wget https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_web_ui.zip && \
    unzip consul_${CONSUL_VERSION}_web_ui.zip -d /ui && \
    rm consul_${CONSUL_VERSION}_web_ui.zip

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 8500

CMD /consul agent -dev -ui -ui-dir /ui -client 0.0.0.0
