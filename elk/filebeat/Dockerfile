FROM phusion/baseimage:0.9.22
MAINTAINER ductamnguyen@anduintransact.com

ARG FILEBEAT_VERSION=6.1.1

RUN apt-get -q update && apt-get -qy install wget && \
    apt-get -qy autoremove && apt-get clean && rm -r /var/lib/apt/lists/* && \
    wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz.sha512 && \
    sha512sum -c filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz.sha512 && \
    tar -xzf filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz && \
    mv filebeat-${FILEBEAT_VERSION}-linux-x86_64 /opt/filebeat && \
    rm filebeat-${FILEBEAT_VERSION}-linux-x86_64.tar.gz*

ADD run-filebeat.sh /etc/service/filebeat/run
ADD default-filebeat.yml /opt/filebeat/default-filebeat.yml

CMD ["/sbin/my_init"]
