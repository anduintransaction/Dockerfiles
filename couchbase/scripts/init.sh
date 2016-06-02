
SERVER=http://dockerhost:8091

until $(curl --output /dev/null --silent --head --fail $SERVER); do
    printf '.'
    sleep 3
done

# Setup Services
printf "setup Services..."
curl -sS -u Administrator:password -v -X POST $SERVER/node/controller/setupServices -d 'services=kv%2Cn1ql%2Cindex' > /dev/null
printf "done\n"

# Initialize Node
printf "initialize Node..."
curl -sS -v -X POST $SERVER/nodes/self/controller/settings -d 'path=%2Fopt%2Fcouchbase%2Fvar%2Flib%2Fcouchbase%2Fdata&index_path=%2Fopt%2Fcouchbase%2Fvar%2Flib%2Fcouchbase%2Fdata' > /dev/null
printf "done\n"

# Setup Administrator username and password
printf "setup Administrator username and password..."
curl -sS -v -X POST $SERVER/settings/web -d 'password=password&username=Administrator&port=SAME' > /dev/null
printf "done\n"

# Setup Bucket
printf "setup Bucket..."
curl -sS -u Administrator:password -v -X POST $SERVER/pools/default/buckets -d 'flushEnabled=1&threadsNumber=3&replicaIndex=0&replicaNumber=0&evictionPolicy=valueOnly&ramQuotaMB=597&bucketType=membase&name=default&authType=sasl&saslPassword=' > /dev/null
printf "done\n"

# Setup Index RAM Quota
printf "setup Index RAM Quota..."
curl -sS -u Administrator:password -X POST $SERVER/pools/default -d 'memoryQuota=2000' -d 'indexMemoryQuota=269' > /dev/null
printf "done\n"