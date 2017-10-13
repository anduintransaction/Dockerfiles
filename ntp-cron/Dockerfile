FROM ubuntu:16.04

RUN apt-get -y update && apt-get install -y ntp && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD run.sh /opt/run.sh

CMD /opt/run.sh
