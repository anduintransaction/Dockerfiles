FROM phusion/baseimage:0.9.22

MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive
ARG KIBANA_VERSION=6.1.3
ARG LOGTRAIL_VERSION=0.1.25

RUN apt-get -q update && apt-get -qy install wget && \
    apt-get -qy autoremove && apt-get clean && rm -r /var/lib/apt/lists/* && \
    wget --quiet https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz && \
    wget --quiet https://artifacts.elastic.co/downloads/kibana/kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz.sha512 && \
    sha512sum -c kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz.sha512 && \
    tar xzf kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz && \
    mv kibana-${KIBANA_VERSION}-linux-x86_64 /opt/kibana && \
    rm -rf kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz kibana-${KIBANA_VERSION}-linux-x86_64.tar.gz.sha512 && \
    /opt/kibana/bin/kibana-plugin install https://github.com/sivasamyk/logtrail/releases/download/v${LOGTRAIL_VERSION}/logtrail-${KIBANA_VERSION}-${LOGTRAIL_VERSION}.zip

ADD ./configs/kibana.yml /opt/kibana/config/kibana.yml
ADD ./configs/logtrail.json /opt/kibana/plugins/logtrail/logtrail.json
ADD ./run-kibana.sh /etc/service/kibana/run

EXPOSE 5601

CMD ["/sbin/my_init"]
