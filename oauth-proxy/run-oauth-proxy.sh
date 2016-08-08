#!/usr/bin/env bash

OAUTH_PROXY_OPTIONS="\
              -client-id=${OAUTH_PROXY_CLIENT_ID} \
              -client-secret=${OAUTH_PROXY_CLIENT_SECRET} \
              -provider=${OAUTH_PROXY_PROVIDER} \
              -email-domain=* \
              -upstream=http://localhost:18001 \
              -cookie-secret=${OAUTH_PROXY_COOKIE_SECRET} \
              -cookie-domain=${OAUTH_PROXY_COOKIE_DOMAIN} \
              -cookie-secure=true \
              -http-address=0.0.0.0:4321 \
              -redirect-url=${OAUTH_PROXY_COOKIE_URL}"

case ${OAUTH_PROXY_PROVIDER} in
     github)
        OAUTH_PROXY_OPTIONS="${OAUTH_PROXY_OPTIONS} \
-login-url=https://github.com/login/oauth/authorize \
-github-org=${OAUTH_GITHUB_ORG}"
        if [ x$OAUTH_GITHUB_TEAM != "x" ]; then
            OAUTH_PROXY_OPTIONS="${OAUTH_PROXY_OPTIONS} \
-github-team=${OAUTH_GITHUB_TEAM}"
        fi
     ;;
     *)
        echo "Provider not found"
        exit 1
     ;;
esac

/oauth2_proxy $OAUTH_PROXY_OPTIONS
