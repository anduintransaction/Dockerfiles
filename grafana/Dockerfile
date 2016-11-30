FROM anduin/consul-template-supervisor:1.1
MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive
ENV GRAFANA_VERSION 4.0.0-1480439068
ENV CONSUL_APP_CONFIG /etc/grafana/grafana.ini

ADD supervisord.conf /etc

RUN apt-get -y update && \
    apt-get install -y adduser libfontconfig && \
    wget https://grafanarel.s3.amazonaws.com/builds/grafana_${GRAFANA_VERSION}_amd64.deb && \
    dpkg -i grafana_${GRAFANA_VERSION}_amd64.deb

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm grafana_${GRAFANA_VERSION}_amd64.deb

CMD ["/run.sh"]
