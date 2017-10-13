#!/usr/bin/env bash

while true; do
    ntpd -g -q
    sleep 300
done
