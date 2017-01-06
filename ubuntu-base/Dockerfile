FROM ubuntu:14.04

MAINTAINER ductamnguyen@anduintransact.com

RUN apt-get -y update && apt-get install -y curl wget

RUN apt-get autoremove -y && \
    apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
