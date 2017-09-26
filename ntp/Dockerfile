FROM alpine

RUN apk update && apk add openntpd

ADD ntpd.conf /etc/ntpd.conf

CMD exec ntpd -d -f /etc/ntpd.conf -s
