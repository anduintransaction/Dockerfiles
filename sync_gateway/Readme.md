```sh
docker run -i -p 80:80 -p 4985:4985 -v /Users/binh/works/anduin/ws2/stargazer/coubase-sync-gateway-config.json:/opt/anduin/couchbase/config.json --link couchbase:couchbase anduin/sync_gateway:latest
```
