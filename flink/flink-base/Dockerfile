FROM anduin/anduin-common:1.3
MAINTAINER ductamnguyen@anduintransact.com

ARG FLINK_VERSION=1.4.0

RUN apt-get update && apt-get install -y netcat gettext-base && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget --quiet http://www.apache.org/dist/flink/flink-${FLINK_VERSION}/flink-${FLINK_VERSION}-bin-scala_2.11.tgz && \
    wget --quiet https://www.apache.org/dist/flink/flink-${FLINK_VERSION}/flink-${FLINK_VERSION}-bin-scala_2.11.tgz.md5 && \
    md5sum -c flink-${FLINK_VERSION}-bin-scala_2.11.tgz.md5 && \
    tar xzf flink-${FLINK_VERSION}-bin-scala_2.11.tgz && \
    mv flink-${FLINK_VERSION} /opt/flink && \
    rm flink-${FLINK_VERSION}-bin-scala_2.11.tgz flink-${FLINK_VERSION}-bin-scala_2.11.tgz.md5 && \
    cp /opt/flink/opt/flink-s3-fs-hadoop-1.4.0.jar /opt/flink/lib/flink-s3-fs-hadoop-1.4.0.jar

ADD ./bin/historyserver-foreground.sh /opt/flink/bin/historyserver-foreground.sh
