# Based on https://github.com/frol/docker-alpine-oraclejdk8
FROM anduin/base:0.5.0
MAINTAINER Binh Nguyen "binhnguyen@anduintransact.com"

ENV JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=45 \
    JAVA_VERSION_BUILD=14 \
    JAVA_PACKAGE=server-jre

RUN cd /tmp && \
    curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz | gunzip -c - | tar -xf - && \
    mv jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/jre /jre && \
    rm /jre/bin/jjs && \
    rm /jre/bin/keytool && \
    rm /jre/bin/orbd && \
    rm /jre/bin/pack200 && \
    rm /jre/bin/policytool && \
    rm /jre/bin/rmid && \
    rm /jre/bin/rmiregistry && \
    rm /jre/bin/servertool && \
    rm /jre/bin/tnameserv && \
    rm /jre/bin/unpack200 && \
    rm /jre/lib/ext/nashorn.jar && \
    rm /jre/lib/jfr.jar && \
    rm -rf /jre/lib/jfr && \
    rm -rf /jre/lib/oblique-fonts && \
    rm -rf /tmp/*

ENV JAVA_HOME=/jre \
    PATH=${PATH}:${JAVA_HOME}/bin \
    LANG=C.UTF-8
