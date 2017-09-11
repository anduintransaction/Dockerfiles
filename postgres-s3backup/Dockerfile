FROM postgres:9.6
MAINTAINER ductamnguyen@anduintransact.com

RUN apt-get -y update && apt-get -y install python-pip && \
    pip install awscli && \
    apt-get autoremove && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD postgres-backup-tools.sh /

ENTRYPOINT ["/postgres-backup-tools.sh"]
