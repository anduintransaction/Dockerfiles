FROM debian:stable
MAINTAINER ductamnguyen@anduintransact.com

ENV VAULT_VERSION=0.8.3

RUN apt-get -y update && apt-get install -y jq wget unzip && \
    wget https://releases.hashicorp.com/vault/$VAULT_VERSION/vault_${VAULT_VERSION}_linux_amd64.zip && \
    unzip vault_${VAULT_VERSION}_linux_amd64.zip && \
    mv vault /usr/bin && \
    rm vault_${VAULT_VERSION}_linux_amd64.zip && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD vault-kube /opt/vault-kube
ENTRYPOINT ["/opt/vault-kube"]
