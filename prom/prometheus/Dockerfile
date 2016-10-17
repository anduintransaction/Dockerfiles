FROM anduin/consul-template-supervisor:1.1

MAINTAINER ductamnguyen@anduintransact.com

ADD entry-point.sh /
ADD run-prometheus.sh /
ADD run-consul.sh /
ADD supervisord.conf /etc

ENV DEBIAN_FRONTEND noninteractive
ENV CONSUL_APP_CONFIG /etc/prometheus.yml
ENV PROMETHEUS_VERSION 1.2.1

RUN wget -O prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz && \
    tar xvzf prometheus.tar.gz && \
    rm prometheus.tar.gz && \
    mv prometheus-${PROMETHEUS_VERSION}.linux-amd64 /opt/prometheus

ENTRYPOINT ["/entry-point.sh"]

CMD ["prometheus"]
