#!/usr/bin/env bash

OAUTH_PROXY_OPTIONS="\
              -client-id=${OAUTH_PROXY_CLIENT_ID} \
              -client-secret=${OAUTH_PROXY_CLIENT_SECRET} \
              -provider=${OAUTH_PROXY_PROVIDER} \
              -email-domain=* \
              -upstream=${OAUTH_PROXY_UPSTREAM} \
              -cookie-secret=${OAUTH_PROXY_COOKIE_SECRET} \
              -cookie-domain=${OAUTH_PROXY_COOKIE_DOMAIN} \
              -http-address=0.0.0.0:4321 \
              -pass-basic-auth=false \
              -pass-access-token=false \
              -redirect-url=${OAUTH_PROXY_COOKIE_URL}"

case ${OAUTH_PROXY_PROVIDER} in
     github)
        OAUTH_PROXY_OPTIONS="${OAUTH_PROXY_OPTIONS} \
-login-url=https://github.com/login/oauth/authorize \
-github-org=${OAUTH_PROXY_GITHUB_ORG}"
        if [ x$OAUTH_PROXY_GITHUB_TEAM != "x" ]; then
            OAUTH_PROXY_OPTIONS="${OAUTH_PROXY_OPTIONS} \
-github-team=${OAUTH_PROXY_GITHUB_TEAM}"
        fi
     ;;
     *)
        echo "Provider not found"
        exit 1
     ;;
esac

if [ x$OAUTH_PROXY_USE_HTTP != 'xtrue' ]; then
    OAUTH_PROXY_OPTIONS="${OAUTH_PROXY_OPTIONS} -cookie-secure=true"
else
    OAUTH_PROXY_OPTIONS="${OAUTH_PROXY_OPTIONS} -cookie-secure=false"
fi

exec /oauth2_proxy $OAUTH_PROXY_OPTIONS
