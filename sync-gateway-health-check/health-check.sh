#/bin/sh

if [ -z "$SYNC_GATEWAY_DATABASE" ]; then
    SYNC_GATEWAY_DATABASE="sync_gateway"
fi

if [ -z "$SYNC_GATEWAY_SERVER" ]; then
    SYNC_GATEWAY_SERVER="localhost:4985"
fi

testKey=sgw-test-key
testValue="{}"

response=`curl -sS -X PUT $SYNC_GATEWAY_SERVER/$SYNC_GATEWAY_DATABASE/$testKey -d "$testValue" -H "Content-Type: application/json"`
if [ $? -ne 0 ]; then
    exit 1
fi

if echo "$response" | grep -q "error"; then
    reason=`echo "$response" | jq -r .reason`
    if [ "$reason" != "Document exists" ]; then
        exit 1
    fi
    getResponse=`curl -sS $SYNC_GATEWAY_SERVER/$SYNC_GATEWAY_DATABASE/$testKey`
    if [ $? -ne 0 ]; then
        exit 1
    fi
    if echo "$getResponse" | grep -q "error"; then
        exit 1
    fi
    rev=`echo "$getResponse" | jq -r "._rev"`
else
    rev=`echo "$response" | jq -r ".rev"`
fi

curl -sS -X DELETE -o /dev/null "$SYNC_GATEWAY_SERVER/$SYNC_GATEWAY_DATABASE/$testKey?rev=$rev"
