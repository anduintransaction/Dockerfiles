FROM anduin/anduin-common:1.3
MAINTAINER ductamnguyen@anduintransact.com

ARG LOGSTASH_VERSION=6.1.3

RUN wget https://artifacts.elastic.co/downloads/logstash/logstash-${LOGSTASH_VERSION}.tar.gz && \
    wget https://artifacts.elastic.co/downloads/logstash/logstash-${LOGSTASH_VERSION}.tar.gz.sha512 && \
    sha512sum -c logstash-${LOGSTASH_VERSION}.tar.gz.sha512 && \
    tar -xzf logstash-${LOGSTASH_VERSION}.tar.gz && \
    mv logstash-${LOGSTASH_VERSION} /opt/logstash && \
    rm logstash-${LOGSTASH_VERSION}.tar.gz*

ADD run-logstash.sh /etc/service/logstash/run
ADD default-logstash.conf /opt/logstash/default-logstash.conf

CMD ["/sbin/my_init"]
