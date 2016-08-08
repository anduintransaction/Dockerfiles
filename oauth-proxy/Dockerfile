FROM ubuntu:14.04

MAINTAINER ductamnguyen@anduintransact.com

# Install nginx & supervisor
RUN apt-get update -y && apt-get install -y --no-install-recommends wget nginx supervisor gettext

# Install oauth proxy
RUN wget --no-check-certificate -O /oauth2_proxy.tar.gz \
    https://github.com/bitly/oauth2_proxy/releases/download/v2.1/oauth2_proxy-2.1.linux-amd64.go1.6.tar.gz && \
    tar xvzf /oauth2_proxy.tar.gz && mv /oauth2_proxy-2.1.linux-amd64.go1.6/oauth2_proxy / && \
    rm -rf /oauth2_proxy.tar.gz /oauth2_proxy-2.1.linux-amd64.go1.6

# Configure nginx
RUN rm -rf /etc/nginx
ADD ./config/nginx /etc/nginx

# Configure supervisord
RUN rm -rf /etc/supervisor && mkdir -p /opt/supervisord/logs
ADD ./config/supervisord /etc/supervisor

COPY run-oauth-proxy.sh /
COPY start-oauth-proxy.sh /

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 4321
CMD ["/start-oauth-proxy.sh"]
