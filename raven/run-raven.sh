#!/usr/bin/env bash

export POSTGRES_HOST=${POSTGRES_HOST:-postgres}
export POSTGRES_USER=${POSTGRES_USER:-raven}
export POSTGRES_PASSWORD=${POSTGRES_PASSWORD:-raven}
export POSTGRES_DB=${POSTGRES_DB:-raven}

exec /opt/raven/raven run /opt/raven.yml --ui-data=/opt/raven/frontend
