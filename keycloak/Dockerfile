FROM anduin/anduin-common:1.0
MAINTAINER ductamnguyen@anduintransact.com

ENV KEYCLOAK_VERSION 3.2.1.Final
RUN wget -O /opt/keycloak-${KEYCLOAK_VERSION}.tar.gz https://downloads.jboss.org/keycloak/${KEYCLOAK_VERSION}/keycloak-${KEYCLOAK_VERSION}.tar.gz && \
    cd /opt && \
    tar xvzf keycloak-${KEYCLOAK_VERSION}.tar.gz && \
    mv keycloak-${KEYCLOAK_VERSION} keycloak && \
    rm keycloak-${KEYCLOAK_VERSION}.tar.gz

ENV POSTGRES_JDBC_VERSION 9.4.1212

RUN wget -O /opt/postgresql-${POSTGRES_JDBC_VERSION}.jar https://jdbc.postgresql.org/download/postgresql-${POSTGRES_JDBC_VERSION}.jar && \
    mkdir -p /opt/keycloak/modules/system/layers/keycloak/org/postgresql/main && \
    mv /opt/postgresql-${POSTGRES_JDBC_VERSION}.jar /opt/keycloak/modules/system/layers/keycloak/org/postgresql/main

RUN apt-get update -y && apt-get install net-tools -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD module.xml /opt/keycloak/modules/system/layers/keycloak/org/postgresql/main/module.xml
ADD changeDatabase.xsl /opt/changeDatabase.xsl

RUN wget -O /opt/saxon.jar http://central.maven.org/maven2/net/sf/saxon/Saxon-HE/9.7.0-18/Saxon-HE-9.7.0-18.jar && \
    java -jar /opt/saxon.jar \
    -s:/opt/keycloak/standalone/configuration/standalone.xml \
    -xsl:/opt/changeDatabase.xsl \
    -o:/opt/keycloak/standalone/configuration/standalone.xml && \
    rm /opt/changeDatabase.xsl /opt/saxon.jar

RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'
    
ADD run-keycloak.sh /opt/keycloak/bin/run-keycloak.sh

ENV VAULT_VERSION=0.8.3

RUN apt-get -y update && apt-get install -y jq unzip && \
    wget https://releases.hashicorp.com/vault/$VAULT_VERSION/vault_${VAULT_VERSION}_linux_amd64.zip && \
    unzip vault_${VAULT_VERSION}_linux_amd64.zip && \
    mv vault /usr/bin && \
    rm vault_${VAULT_VERSION}_linux_amd64.zip && \
    wget https://raw.githubusercontent.com/anduintransaction/Dockerfiles/master/vault-kube/vault-kube && \
    mv vault-kube /usr/bin && \
    chmod 755 /usr/bin/vault-kube && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]

CMD ["server"]
