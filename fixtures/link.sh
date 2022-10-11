#/usr/bin/env bash

# Write a quote
curl  -v \
 --data-urlencode  "user=stahnma" \
 --data-urlencode  "url=http://www.reddit.com" \
   http://giga2:4567/link
