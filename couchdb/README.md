# CouchDB 1.6.1 and couchperuser plugin

How to use:
```
docker pull anduin/couchdb:0.3.1
docker run -it -p 5984:5984 anduin/couchdb:0.3.1
```

Add new `test` user: 
```
http -a admin:admin \
PUT http://dockerhost:5984/_users/org.couchdb.user:test \
name=test password=testPassword roles:='["tester", "dev"]' type=user
```
note that you will need to replace `dockerhost` with the correct host for your docker container. You should see output similiar to this:
```
HTTP/1.1 201 Created
Cache-Control: must-revalidate
Content-Length: 84
Content-Type: application/json
Date: Mon, 02 Feb 2015 10:31:40 GMT
ETag: "1-7b268281ba16b8ea5eee22c151cfaacf"
Location: http://dockerhost:5984/_users/org.couchdb.user:test
Server: CouchDB/1.6.1 (Erlang OTP/17)

{
    "id": "org.couchdb.user:test",
    "ok": true,
    "rev": "1-7b268281ba16b8ea5eee22c151cfaacf"
}
```

After that, you can verify that the new database for `test` user is properly created:
```
http -a test:testPassword \
GET http://dockerhost:5984/userdb-74657374
```
and expect the output to be something similiar to:
```
HTTP/1.1 200 OK
Cache-Control: must-revalidate
Content-Length: 236
Content-Type: text/plain; charset=utf-8
Date: Mon, 02 Feb 2015 10:38:55 GMT
Server: CouchDB/1.6.1 (Erlang OTP/17)

{"db_name":"userdb-74657374","doc_count":0,"doc_del_count":0,"update_seq":1,"purge_seq":0,"compact_running":false,"disk_size":4171,"data_size":0,"instance_start_time":"1422873100506761","disk_format_version":6,"committed_update_seq":1}
```
