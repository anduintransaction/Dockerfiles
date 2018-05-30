FROM ubuntu:16.04

RUN  apt-get update \
  && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

ADD wait.sh /opt/wait.sh

CMD exec /opt/wait.sh
