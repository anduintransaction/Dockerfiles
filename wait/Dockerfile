FROM ubuntu:16.04

RUN  apt-get update \
  && apt-get install -y curl \
  && rm -rf /var/lib/apt/lists/*

ADD wait.sh /opt/wait.sh

CMD exec /opt/wait.sh
