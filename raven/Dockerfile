FROM ubuntu:16.04

ARG RAVEN_VERSION=1.0.0

RUN apt-get update && apt-get -y install wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget https://github.com/anduintransaction/raven/releases/download/v${RAVEN_VERSION}/raven-linux-amd64-v${RAVEN_VERSION}.tar.gz && \
    tar xzf raven-linux-amd64-v${RAVEN_VERSION}.tar.gz && \
    mv raven /opt && \
    rm raven-linux-amd64-v${RAVEN_VERSION}.tar.gz

ADD run-raven.sh /opt/run-raven.sh
ADD raven.yml /opt/raven.yml

CMD /opt/run-raven.sh
