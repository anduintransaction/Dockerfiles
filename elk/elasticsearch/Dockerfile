FROM anduin/consul-template-supervisor:1.1

MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive
ENV CONSUL_APP_CONFIG /etc/elasticsearch/elasticsearch.yml

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

RUN wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add - && \
    echo "deb https://packages.elastic.co/elasticsearch/2.x/debian stable main" | tee -a /etc/apt/sources.list.d/elasticsearch-2.x.list && \
    apt-get -y update && apt-get -y install elasticsearch

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD supervisord.conf /etc/supervisord.conf

CMD /run.sh
