FROM phusion/baseimage:0.9.22

RUN apt-get update && apt-get install -y wget && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Java
RUN wget --quiet \
    --output-document=/jdk-8.tar.gz \
    --no-check-certificate \
    --no-cookies \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.tar.gz && \
    mkdir -p /usr/lib/jvm && \
    tar -xzf /jdk-8.tar.gz --directory /usr/lib/jvm && \
    rm -f /jdk-8.tar.gz && \
    chown -R root:root /usr/lib/jvm

# set the environment variables
ENV JDK_HOME /usr/lib/jvm/jdk1.8.0_152
ENV JAVA_HOME /usr/lib/jvm/jdk1.8.0_152
ENV PATH $JAVA_HOME/bin:$PATH

# Nexus

ARG NEXUS_VERSION=3.12.0-01
RUN wget --quiet \
    -O /nexus.tar.gz \
    https://download.sonatype.com/nexus/3/nexus-${NEXUS_VERSION}-unix.tar.gz && \
    tar xzf /nexus.tar.gz --directory /opt && \
    rm -f /nexus.tar.gz && \
    mv /opt/nexus-${NEXUS_VERSION} /opt/nexus && \
    rm -rf /opt/sonatype-work

ADD run-nexus.sh /etc/service/nexus/run

CMD ["/sbin/my_init"]
