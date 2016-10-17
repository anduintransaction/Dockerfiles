FROM ubuntu:14.04

MAINTAINER ductamnguyen@anduintransact.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com C300EE8C && \
    apt-get -y update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:nginx/stable && \
    apt-get -y update && \
    apt-get -y install nginx supervisor

RUN apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rm -rf /etc/nginx
ADD nginx.conf /etc/nginx/nginx.conf
ADD supervisord.conf /

CMD supervisord -c /supervisord.conf
