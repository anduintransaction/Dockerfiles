#!/usr/bin/env python2
from oauth import oauth # pip install oauth
import httplib

URL = 'http://95baa9c7.ngrok.io/userdb-6e6762696e6840676d61696c2e636f6d'
CONSUMER_KEY = 'ngbinh@gmail.com'
CONSUMER_SECRET = 'binh'
TOKEN = 'binh'
SECRET = 'binh'

consumer = oauth.OAuthConsumer(CONSUMER_KEY, CONSUMER_SECRET)
token = oauth.OAuthToken(TOKEN, SECRET)
req = oauth.OAuthRequest.from_consumer_and_token(
    consumer,
    token=token,
    http_method='GET',
    http_url=URL)
req.sign_request(oauth.OAuthSignatureMethod_HMAC_SHA1(), consumer,token)

headers = req.to_header()
headers['Accept'] = 'application/json'

con = httplib.HTTPConnection('http://95baa9c7.ngrok.io', 80)
con.request('GET', URL, headers=headers)
resp = con.getresponse()
print resp.read()
