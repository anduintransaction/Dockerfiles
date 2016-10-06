FROM ubuntu:14.04

MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive
ENV CONSUL_TEMPLATE_VERSION 0.16.0

RUN apt-get update -y && apt-get install -y --no-install-recommends wget supervisor ca-certificates unzip curl

RUN wget -O consul-template.zip https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip \
    && unzip consul-template.zip \
    && mv consul-template /usr/local/bin \
    && rm -rf consul-template.zip

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY run-app.sh /
