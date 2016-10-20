FROM anduin/consul-template-supervisor:1.1

MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive
ENV FILEBEAT_VERSION 1.3.1
ENV CONSUL_APP_CONFIG /opt/filebeat.yml

# Filebeat
RUN wget --quiet https://download.elastic.co/beats/filebeat/filebeat-${FILEBEAT_VERSION}-x86_64.tar.gz && \
    tar xvzf filebeat-${FILEBEAT_VERSION}-x86_64.tar.gz && \
    mv filebeat-${FILEBEAT_VERSION}-x86_64/filebeat /opt && \
    rm -rf filebeat-${FILEBEAT_VERSION}-x86_64*

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD supervisord.conf /etc/supervisord.conf

CMD /run.sh
