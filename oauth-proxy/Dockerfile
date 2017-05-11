FROM anduin/consul-template-supervisor:1.1

MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive
ENV CONSUL_APP_CONFIG /etc/oauth-proxy.toml
ENV OAUTH_PROXY_VERSION 0.4.0

RUN wget --quiet https://github.com/anduintransaction/oauth-proxy/releases/download/${OAUTH_PROXY_VERSION}/oauth-proxy-${OAUTH_PROXY_VERSION}-linux-amd64.tar.gz && \
    tar xvzf oauth-proxy-${OAUTH_PROXY_VERSION}-linux-amd64.tar.gz && \
    rm oauth-proxy-${OAUTH_PROXY_VERSION}-linux-amd64.tar.gz

ADD supervisord.conf /etc/supervisord.conf

CMD /run.sh
