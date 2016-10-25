FROM anduin/consul-template-supervisor:1.1

MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive
ENV KIBANA_VERSION 4.6.1
ENV CONSUL_APP_CONFIG /opt/kibana/config/kibana.yml

# Kibana
RUN wget --quiet https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz && \
    tar xvzf kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz && \
    mv kibana-${KIBANA_VERSION}-linux-x86_64 /opt/kibana && \
    rm -rf kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz

# Logtrail
RUN /opt/kibana/bin/kibana plugin -i logtrail -u https://github.com/anduintransaction/logtrail/releases/download/0.1.4-anduin-1/logtrail-0.1.4-anduin-1.tar.gz

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD supervisord.conf /etc/supervisord.conf
ADD run-consul.sh /opt

CMD /opt/run-consul.sh
