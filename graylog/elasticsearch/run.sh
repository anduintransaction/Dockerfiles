#!/usr/bin/env bash

/etc/init.d/elasticsearch restart

exec /loop.sh
