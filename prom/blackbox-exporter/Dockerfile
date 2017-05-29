FROM anduin/consul-template-supervisor:1.1

MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive
ENV BLACKBOX_EXPORTER_VERSION 0.5.0
ENV CONSUL_APP_CONFIG /opt/blackbox_exporter.yml

ADD supervisord.conf /etc

RUN wget -O blackbox_exporter.tar.gz https://github.com/prometheus/blackbox_exporter/releases/download/v${BLACKBOX_EXPORTER_VERSION}/blackbox_exporter-${BLACKBOX_EXPORTER_VERSION}.linux-amd64.tar.gz && \
    tar xvzf blackbox_exporter.tar.gz && \
    rm blackbox_exporter.tar.gz && \
    mv blackbox_exporter-${BLACKBOX_EXPORTER_VERSION}.linux-amd64/blackbox_exporter /opt/blackbox_exporter

CMD /run.sh
