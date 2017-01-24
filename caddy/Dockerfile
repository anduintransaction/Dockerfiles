FROM anduin/consul-template-supervisor:1.1
MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive
ENV CONSUL_APP_CONFIG /opt/Caddyfile
ENV CADDYPATH /data/caddy

RUN wget -O caddy.tar.gz 'https://caddyserver.com/download/build?os=linux&arch=amd64&features=cors%2Cprometheus%2Cratelimit%2Croute53' && \
    mkdir caddy && \
    mv caddy.tar.gz caddy && \
    cd caddy && \
    tar xvzf caddy.tar.gz && \
    mv caddy /opt/caddy && \
    cd .. && \
    rm -rf caddy

ADD supervisord.conf /etc
VOLUME /data/caddy

CMD exec /run.sh
