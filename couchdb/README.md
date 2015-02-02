# CouchDB 1.6.1 and couchperuser plugin

How to use:
```
docker pull anduin/couchdb:0.3.1
docker run -it -p 5984:5984 anduin/couchdb:0.3.1
```

Add new user: 
```
http -a admin:admin \
     PUT http://dockerhost:5984/_users/org.couchdb.user:test \
     name=test password=testPassword roles:='["tester", "dev"]' type=user
```
note that you will need to replace `dockerhost` with the correct host for your docker container.
