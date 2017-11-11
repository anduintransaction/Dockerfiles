FROM gcr.io/google-containers/exechealthz-amd64:v1.2.0
MAINTAINER ductamnguyen@anduintransact.com

USER root
RUN apk update && apk add curl jq
ADD health-check.sh /opt/health-check.sh

USER nobody

CMD ["-cmd", "/opt/health-check.sh", "-period", "30s", "-latency", "1m", "-quiet"]
