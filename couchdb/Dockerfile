# Based on https://github.com/klaemo/docker-couchdb
FROM anduin/base:0.3.1
MAINTAINER Binh Nguyen "binhnguyen@anduintransact.com"

RUN add-apt-repository ppa:couchdb/stable && \
    apt-get update -y \
  && apt-get install -y --no-install-recommends \
  couchdb rebar

COPY local.ini /usr/local/etc/couchdb/
