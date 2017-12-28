FROM phusion/baseimage:0.9.22
MAINTAINER ductamnguyen@anduintransact.com

ENV OAUTH_PROXY_VERSION 0.4.0

RUN wget --quiet https://github.com/anduintransaction/oauth-proxy/releases/download/${OAUTH_PROXY_VERSION}/oauth-proxy-${OAUTH_PROXY_VERSION}-linux-amd64.tar.gz && \
    tar xvzf oauth-proxy-${OAUTH_PROXY_VERSION}-linux-amd64.tar.gz && \
    mv oauth-proxy /opt && \
    rm oauth-proxy-${OAUTH_PROXY_VERSION}-linux-amd64.tar.gz

ADD run-oauth-proxy.sh /etc/service/oauth-proxy/run

CMD ["/sbin/my_init"]
