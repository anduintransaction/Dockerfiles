FROM golang:1.9-alpine
MAINTAINER ductamnguyen@anduintransact.com

ENV CADDYPATH=/data/caddy CADDY_VERSION=0.10.9

RUN mkdir -p $GOPATH/src/github.com/mholt && \
    cd $GOPATH/src/github.com/mholt && \
    apk add --update ca-certificates openssl && update-ca-certificates && \
    wget https://github.com/mholt/caddy/archive/v$CADDY_VERSION.zip && \
    unzip v$CADDY_VERSION.zip && mv caddy-$CADDY_VERSION caddy && \
    cd caddy/caddy && go install && cd / && rm -rf $GOPATH/src $GOPATH/pkg

ADD entrypoint.sh /opt/entrypoint.sh

VOLUME /data/caddy

ENTRYPOINT "/opt/entrypoint.sh"
