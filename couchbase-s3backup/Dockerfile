FROM anduin/couchbase:5.0.1
MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive

# Couchbase
RUN apt-get update && \
    apt-get -y install python-pip curl && \
    pip install awscli && \
    apt-get autoremove && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install cbtools
ADD couchbase-backup-tools.sh /opt

ENTRYPOINT ["/opt/couchbase-backup-tools.sh"]
