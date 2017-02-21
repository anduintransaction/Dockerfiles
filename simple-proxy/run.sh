#!/usr/bin/env bash

simple-proxy $@ && exec nginx -g 'daemon off;'