#!/usr/bin/env bash

/usr/local/bin/envconsul -log-level debug -consul $CONSUL_ENDPOINT -prefix $CONSUL_PREFIX /run-oauth-proxy.sh
