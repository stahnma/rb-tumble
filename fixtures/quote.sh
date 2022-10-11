#/usr/bin/env bash

# Write a quote
curl  -v \
 --data-urlencode  "author=stahnma" \
 --data-urlencode  "quote=I know what you did last summer." \
   http://giga2:4567/quote

curl  -v \
 --data-urlencode  "author=John Lennon" \
 --data-urlencode  "quote=All you need is love" \
   http://giga2:4567/quote
