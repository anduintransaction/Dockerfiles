FROM redis:4.0.9

RUN apt-get -y update && apt-get -y install curl python-dev python-pip && \
    pip install awscli && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && \
    apt-get autoremove && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    npm install -g redis-dump@0.1.10

ADD redis-s3-backup-tools.sh /opt/redis-s3-backup-tools.sh

ENTRYPOINT ["/opt/redis-s3-backup-tools.sh"]
