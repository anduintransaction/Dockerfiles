
FROM anduin/consul-template
MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install apt-transport-https wget curl && \
    wget https://packages.graylog2.org/repo/packages/graylog-2.1-repository_latest.deb && \
    dpkg -i graylog-2.1-repository_latest.deb && \
    apt-get update && \
    apt-get install -y graylog-server

# Install JDK 8
RUN wget --quiet \
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
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* graylog-2.1-repository_latest.deb

ADD graylog /
ADD run.sh /

CMD /run.sh
