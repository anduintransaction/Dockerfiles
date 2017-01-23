FROM anduin/consul-template-supervisor:1.1
MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive
ENV CADDY_VERSION v0.9.4
ENV CONSUL_APP_CONFIG /opt/Caddyfile
ENV CADDYPATH /data/caddy

RUN wget https://github.com/mholt/caddy/releases/download/$CADDY_VERSION/caddy_linux_amd64.tar.gz && \
    mkdir caddy && \
    mv caddy_linux_amd64.tar.gz caddy && \
    cd caddy && \
    tar xvzf caddy_linux_amd64.tar.gz && \
    mv caddy_linux_amd64 /opt/caddy && \
    cd .. && \
    rm -rf caddy

ADD supervisord.conf /etc
VOLUME /data/caddy

CMD exec /run.sh
