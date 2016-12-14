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

RUN wget https://github.com/anduintransaction/sync_gateway/releases/download/1.3-anduin-v1/sync_gateway-1.3.1-anduin-linux-amd64.tar.gz && \
    tar xvzf sync_gateway-1.3.1-anduin-linux-amd64.tar.gz && \
    mv sync_gateway /opt && \
    rm sync_gateway-1.3.1-anduin-linux-amd64.tar.gz

ENV SYNC_GATEWAY_CONFIG_FILE /opt/sync-gateway-config.json

RUN rm -rf /etc/nginx
ADD ./config/nginx /etc/nginx
ADD ./config/supervisord/supervisord.conf /opt
ADD ./run-sync-gateway.sh /opt
ADD ./run-consul.sh /opt

CMD exec supervisord -c /opt/supervisord.conf
