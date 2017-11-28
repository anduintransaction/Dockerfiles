FROM ubuntu:16.04
MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && apt-get -o Dpkg::Options::="--force-confnew" install -yq \
    wget netcat net-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install JDK 8
RUN wget --quiet \
    --output-document=/jdk-8.tar.gz \
    --no-check-certificate \
    --no-cookies \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz && \
    mkdir -p /usr/lib/jvm && \
    tar --gunzip --extract --file /jdk-8.tar.gz --directory /usr/lib/jvm && \
    rm -f /jdk-8.tar.gz && \
    chown -R root:root /usr/lib/jvm

# set the environment variables
ENV JDK_HOME /usr/lib/jvm/jdk1.8.0_151
ENV JAVA_HOME /usr/lib/jvm/jdk1.8.0_151
ENV PATH $JAVA_HOME/bin:$PATH

ENV KAFKA_VERSION 1.0.0
RUN wget --quiet http://www-us.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_2.12-${KAFKA_VERSION}.tgz && \
    tar xzf kafka_2.12-${KAFKA_VERSION}.tgz && \
    mv kafka_2.12-${KAFKA_VERSION} /opt/kafka && \
    rm kafka_2.12-${KAFKA_VERSION}.tgz

RUN apt-get update && apt-get -o Dpkg::Options::="--force-confnew" install -yq \
    netcat net-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./configs /opt/configs
ADD ./services/run-kafka.sh /opt/run-kafka.sh
RUN chmod +x /opt/run-kafka.sh

VOLUME /data

ENTRYPOINT ["/opt/run-kafka.sh"]

CMD ["server"]
