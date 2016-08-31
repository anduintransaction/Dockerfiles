FROM anduin/envconsul

MAINTAINER ductamnguyen@anduintransact.com

# Install oauth proxy
RUN wget --no-check-certificate -O /oauth2_proxy.tar.gz \
    https://github.com/bitly/oauth2_proxy/releases/download/v2.1/oauth2_proxy-2.1.linux-amd64.go1.6.tar.gz && \
    tar xvzf /oauth2_proxy.tar.gz && mv /oauth2_proxy-2.1.linux-amd64.go1.6/oauth2_proxy / && \
    rm -rf /oauth2_proxy.tar.gz /oauth2_proxy-2.1.linux-amd64.go1.6

COPY run-oauth-proxy.sh /
COPY start-oauth-proxy.sh /

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 4321
CMD ["/start-oauth-proxy.sh"]
