#!/usr/bin/env bash

/usr/local/bin/envconsul -consul $CONSUL_ENDPOINT -prefix $CONSUL_PREFIX /run-oauth-proxy.sh
