#!/usr/bin/env bash

SENTRY_CONF=/etc/sentry C_FORCE_ROOT=true exec sentry run worker
