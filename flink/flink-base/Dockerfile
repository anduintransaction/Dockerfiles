FROM anduin/anduin-common:1.3
MAINTAINER ductamnguyen@anduintransact.com

ARG FLINK_VERSION=1.4.0
ARG HADOOP_VERSION=2.8.3
ARG HADOOP_SHARE_LIB=hadoop-${HADOOP_VERSION}/share/hadoop/tools/lib

RUN apt-get update && apt-get install -y netcat gettext-base && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget --quiet http://www.apache.org/dist/flink/flink-${FLINK_VERSION}/flink-${FLINK_VERSION}-bin-scala_2.11.tgz && \
    wget --quiet https://www.apache.org/dist/flink/flink-${FLINK_VERSION}/flink-${FLINK_VERSION}-bin-scala_2.11.tgz.md5 && \
    md5sum -c flink-${FLINK_VERSION}-bin-scala_2.11.tgz.md5 && \
    tar xzf flink-${FLINK_VERSION}-bin-scala_2.11.tgz && \
    mv flink-${FLINK_VERSION} /opt/flink && \
    rm flink-${FLINK_VERSION}-bin-scala_2.11.tgz flink-${FLINK_VERSION}-bin-scala_2.11.tgz.md5 && \
    cp /opt/flink/opt/flink-s3-fs-hadoop-1.4.0.jar /opt/flink/lib/flink-s3-fs-hadoop-1.4.0.jar && \
    wget --quiet http://www.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar xzf hadoop-${HADOOP_VERSION}.tar.gz && \
    cp \
       ${HADOOP_SHARE_LIB}/hadoop-aws-*.jar \
       ${HADOOP_SHARE_LIB}/aws-java-sdk-s3-*.jar \
       ${HADOOP_SHARE_LIB}/aws-java-sdk-core-*.jar \
       ${HADOOP_SHARE_LIB}/aws-java-sdk-kms-*.jar \
       ${HADOOP_SHARE_LIB}/jackson-annotations-*.jar \
       ${HADOOP_SHARE_LIB}/jackson-core-*.jar \
       ${HADOOP_SHARE_LIB}/jackson-databind-*.jar \
       ${HADOOP_SHARE_LIB}/joda-time-*.jar \
       ${HADOOP_SHARE_LIB}/httpcore-*.jar \
       ${HADOOP_SHARE_LIB}/httpclient-*.jar \
       ${HADOOP_SHARE_LIB}/guava-*.jar \
       /opt/flink/lib && \
    rm -rf hadoop-${HADOOP_VERSION}.tar.gz hadoop-${HADOOP_VERSION}.tar.gz.md5 hadoop-${HADOOP_VERSION}

ADD ./bin/historyserver-foreground.sh /opt/flink/bin/historyserver-foreground.sh
