FROM ubuntu:14.04

MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive

# Install supervisor
RUN apt-get update -y && apt-get install -y --no-install-recommends wget ca-certificates unzip

# Install consul-template
RUN wget -O envconsul.zip https://releases.hashicorp.com/envconsul/0.6.1/envconsul_0.6.1_linux_amd64.zip \
    && unzip envconsul.zip \
    && mv envconsul /usr/local/bin \
    && rm -rf envconsul.zip
