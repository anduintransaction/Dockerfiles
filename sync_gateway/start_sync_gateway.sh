#!/usr/bin/env bash

# we need to set the permissions here because docker mounts volumes as root
chown -R couchbase:couchbase /opt/anduin/sync_gateway/

# Run everything
/usr/bin/supervisord --configuration /etc/supervisor/supervisord.conf
