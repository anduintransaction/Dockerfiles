#!/usr/bin/env bash

echo "{{key \"$CONSUL_KEY\"}}" > /tmp/td-agent.conf.tmpl
