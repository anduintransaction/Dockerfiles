FROM anduin/anduin-common:1.2
MAINTAINER ductamnguyen@anduintransact.com

ENV ZOOKEEPER_VERSION 3.4.11
ENV KAFKA_VERSION 1.0.0
RUN wget --quiet http://www-us.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz && \
    tar xzf zookeeper-${ZOOKEEPER_VERSION}.tar.gz && \
    mv zookeeper-${ZOOKEEPER_VERSION} /opt/zookeeper && \
    rm zookeeper-${ZOOKEEPER_VERSION}.tar.gz && \
    wget --quiet http://www-us.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_2.12-${KAFKA_VERSION}.tgz && \
    tar xzf kafka_2.12-${KAFKA_VERSION}.tgz && \
    mv kafka_2.12-${KAFKA_VERSION} /opt/kafka && \
    rm kafka_2.12-${KAFKA_VERSION}.tgz

RUN apt-get update && apt-get -o Dpkg::Options::="--force-confnew" install -yq \
    netcat net-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./configs /opt/configs
RUN mkdir -p /etc/service/zookeeper
ADD ./services/run-zookeeper.sh /etc/service/zookeeper/run
RUN chmod +x /etc/service/zookeeper/run

RUN mkdir -p /etc/service/kafka
ADD ./services/run-kafka.sh /etc/service/kafka/run
RUN chmod +x /etc/service/kafka/run

VOLUME /data

CMD ["/sbin/my_init"]
