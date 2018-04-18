FROM anduin/anduin-common:1.3

RUN wget --quiet 'https://dl.bintray.com/maif/binaries/izanami.jar/1.0.4/izanami.jar' -O /opt/izanami.jar
ADD run.sh /etc/service/izanami/run

CMD ["/sbin/my_init"]
