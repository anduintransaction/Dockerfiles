FROM anduin/consul-template-supervisor:1.1

MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive
ENV ALERT_MANAGER_VERSION 0.4.2
ENV CONSUL_APP_CONFIG /opt/alertmanager.yml

RUN wget -O alertmanager.tar.gz https://github.com/prometheus/alertmanager/releases/download/v${ALERT_MANAGER_VERSION}/alertmanager-${ALERT_MANAGER_VERSION}.linux-amd64.tar.gz && \
    tar xvzf alertmanager.tar.gz && \
    rm alertmanager.tar.gz && \
    mv alertmanager-${ALERT_MANAGER_VERSION}.linux-amd64/alertmanager /opt

ADD supervisord.conf /etc

CMD /run.sh
