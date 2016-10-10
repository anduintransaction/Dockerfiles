FROM anduin/consul-template-supervisor:1.1

MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive

ENV PROMETHEUS_VERSION 1.2.0

RUN wget -O prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz && \
    tar xvzf prometheus.tar.gz && \
    rm prometheus.tar.gz && \
    mv prometheus-${PROMETHEUS_VERSION}.linux-amd64 /opt/prometheus

ADD entry-point.sh /
ADD run-prometheus.sh /
ADD supervisord.conf /etc

ENTRYPOINT ["/entry-point.sh"]

CMD ["prometheus"]
