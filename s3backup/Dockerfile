FROM ubuntu:16.04
MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get -y install python-pip && \
    pip install awscli && \
    apt-get autoremove && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD s3-backup-tools.sh /opt/s3-backup-tools.sh

ENTRYPOINT ["/opt/s3-backup-tools.sh"]
