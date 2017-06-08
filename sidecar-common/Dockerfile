FROM ubuntu:16.04

MAINTAINER ductamnguyen@anduintransact.com

RUN apt-get -y update && \
    apt-get -y install wget curl python && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
