#!/usr/bin/env bash

ELASTICSEARCH_URL=${ELASTICSEARCH_URL:-http://localhost:9200}
LOGTRAIL_DEFAULT_INDEX=${LOGTRAIL_DEFAULT_INDEX:-elasticsearch}
LOGTRAIL_MAPPING_TIMESTAMP=${LOGTRAIL_MAPPING_TIMESTAMP:-@timestamp}
LOGTRAIL_MAPPING_HOSTNAME=${LOGTRAIL_MAPPING_HOSTNAME:-hostname}
LOGTRAIL_MAPPING_PROGRAM=${LOGTRAIL_MAPPING_PROGRAM:-program}
LOGTRAIL_MAPPING_MESSAGE=${LOGTRAIL_MAPPING_MESSAGE:-message}
LOGTRAIL_MESSAGE_FORMAT=${LOGTRAIL_MESSAGE_FORMAT:-"{{{message}}}"}

sed -i "s!ELASTICSEARCH_URL!$ELASTICSEARCH_URL!" /opt/kibana/config/kibana.yml
sed -i "s!LOGTRAIL_DEFAULT_INDEX!$LOGTRAIL_DEFAULT_INDEX!" /opt/kibana/plugins/logtrail/logtrail.json
sed -i "s!LOGTRAIL_MAPPING_TIMESTAMP!$LOGTRAIL_MAPPING_TIMESTAMP!" /opt/kibana/plugins/logtrail/logtrail.json
sed -i "s!LOGTRAIL_MAPPING_HOSTNAME!$LOGTRAIL_MAPPING_HOSTNAME!" /opt/kibana/plugins/logtrail/logtrail.json
sed -i "s!LOGTRAIL_MAPPING_PROGRAM!$LOGTRAIL_MAPPING_PROGRAM!" /opt/kibana/plugins/logtrail/logtrail.json
sed -i "s!LOGTRAIL_MAPPING_MESSAGE!$LOGTRAIL_MAPPING_MESSAGE!" /opt/kibana/plugins/logtrail/logtrail.json
sed -i "s!LOGTRAIL_MESSAGE_FORMAT!$LOGTRAIL_MESSAGE_FORMAT!" /opt/kibana/plugins/logtrail/logtrail.json

exec /opt/kibana/bin/kibana
