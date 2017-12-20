FROM anduin/anduin-common:1.3
MAINTAINER ductamnguyen@anduintransact.com

ENV CONFLUENT_VERSION_SHORT 4.0
ENV CONFLUENT_VERSION_LONG 4.0.0
ENV CONFLUENT_VERSION_SCALA 2.11
ENV CONFLUENT_USER confluent
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -o Dpkg::Options::="--force-confnew" install -yq \
    netcat net-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install confluent
RUN wget --quiet -O confluent.tar.gz \
    http://packages.confluent.io/archive/${CONFLUENT_VERSION_SHORT}/confluent-oss-${CONFLUENT_VERSION_LONG}-${CONFLUENT_VERSION_SCALA}.tar.gz && \
    tar xzf confluent.tar.gz && \
    mv confluent-${CONFLUENT_VERSION_LONG} /opt/confluent && \
    rm confluent.tar.gz

# Fix for kafka-run-class
RUN cp /opt/confluent/bin/kafka-run-class /opt/confluent/bin/kafka-run-class.sh
