FROM phusion/baseimage:0.9.22

ARG SENTRY_VERSION=8.22.0

RUN apt-get -y update && \
    apt-get install -y \
            python-setuptools \
            python-pip \
            python-dev \
            libxslt1-dev \
            gettext \
            gcc \
            libffi-dev \
            libjpeg-dev \
            libxml2-dev \
            libxslt-dev \
            libyaml-dev \
            libpq-dev \
            redis-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    pip install sentry==$SENTRY_VERSION && \
    pip install sentry-plugins==$SENTRY_VERSION && \
    pip install https://github.com/getsentry/sentry-auth-github/archive/master.zip

ADD config /etc/sentry
ADD scripts/init-sentry.sh /etc/my_init.d/99_sentry.sh
ADD scripts/run-sentry-web.sh /etc/service/sentry-web/run
ADD scripts/run-sentry-worker.sh /etc/service/sentry-worker/run
ADD scripts/run-sentry-cron.sh /etc/service/sentry-cron/run

CMD ["/sbin/my_init"]
