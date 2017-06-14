## -*- docker-image-name: "anduin/keycloak-cli:1.0" -*-

FROM anduin/anduin-common:1.0
MAINTAINER ductamnguyen@anduintransact.com

ENV KEYCLOAK_VERSION 3.1.0.Final
RUN wget -O /opt/keycloak-${KEYCLOAK_VERSION}.tar.gz https://downloads.jboss.org/keycloak/3.1.0.Final/keycloak-${KEYCLOAK_VERSION}.tar.gz && \
    cd /opt && \
    tar xvzf keycloak-${KEYCLOAK_VERSION}.tar.gz && \
    mv keycloak-${KEYCLOAK_VERSION} keycloak && \
    rm keycloak-${KEYCLOAK_VERSION}.tar.gz
