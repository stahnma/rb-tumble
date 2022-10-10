#/usr/bin/env bash

# Write a quote
curl  -v \
 --data-urlencode  "author=stahnma" \
 --data-urlencode  "quote=I know what you did last summer." \
   http://giga2:4567/quote

