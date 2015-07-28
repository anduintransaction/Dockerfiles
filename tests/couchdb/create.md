http -a admin:admin \
     PUT http://dockerhost:5984/_users/org.couchdb.user:test1 \
     name=test1 password=testPassword type=user oauth:=@test1.json roles:='["test", "dev"]'

http http://dockerhost:5984/_oauth/request_token

http --auth-type=oauth1 --auth='requestkey:requestsecret' http://dockerhost:5984/_oauth/request_token

http -a admin:admin \
     PUT http://dockerhost:5984/_users/org.couchdb.user:ngbinh@gmail.com \
     name=ngbinh@gmail.com password=test2Password type=user oauth:=@binh.json roles:='["test", "dev"]' If-Match:1-0fd5ec646a2e94a10eb3610f04ef1964

http -a admin:admin GET http://dockerhost:5984/_users/org.couchdb.user:ngbinh@gmail.com
