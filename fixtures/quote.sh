#/usr/bin/env bash

# Write a quote
curl  -v \
 --data-urlencode  "author=stahnma" \
 --data-urlencode  "quote=I know what you did last summer." \
   $WEBURI/quote

curl  -v \
 --data-urlencode  "author=John Lennon" \
 --data-urlencode  "quote=All you need is love" \
   $WEBURI/quote
