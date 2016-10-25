FROM anduin/consul-template-supervisor:1.1

MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive
ENV LOGSTASH_VERSION 2.4.0
ENV CONSUL_APP_CONFIG /etc/logstash.conf

# Install JDK 8
RUN apt-get --quiet update && \
    apt-get --quiet --yes install wget apt-transport-https curl && \
    apt-get clean && \
    wget --quiet \
    --output-document=/jdk-8.tar.gz \
    --no-check-certificate \
    --no-cookies \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz && \
    mkdir -p /usr/lib/jvm && \
    tar --gunzip --extract --verbose --file /jdk-8.tar.gz --directory /usr/lib/jvm && \
    rm -f /jdk-8.tar.gz && \
    chown -R root:root /usr/lib/jvm

ENV JDK_HOME /usr/lib/jvm/jdk1.8.0_101
ENV JAVA_HOME /usr/lib/jvm/jdk1.8.0_101
ENV PATH $PATH:$JAVA_HOME/bin

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Logstash
RUN wget --quiet https://download.elastic.co/logstash/logstash/logstash-${LOGSTASH_VERSION}.tar.gz && \
    tar xzf logstash-${LOGSTASH_VERSION}.tar.gz && \
    mv logstash-${LOGSTASH_VERSION} /opt/logstash && \
    rm logstash-${LOGSTASH_VERSION}.tar.gz && \
    /opt/logstash/bin/logstash-plugin install logstash-filter-kubernetes

RUN wget --quiet https://github.com/anduintransaction/logstash-codec-json_kubernetes/releases/download/0.1.0/logstash-codec-json_kubernetes-0.1.0.gem && \
    /opt/logstash/bin/logstash-plugin install logstash-codec-json_kubernetes-0.1.0.gem && \
    rm logstash-codec-json_kubernetes-0.1.0.gem

ADD supervisord.conf /etc/supervisord.conf

CMD /run.sh
