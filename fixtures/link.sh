#/usr/bin/env bash

curl  -v \
 --data-urlencode  "user=stahnma" \
 --data-urlencode  "url=http://www.reddit.com" \
   http://giga2:4567/link

curl  -v \
 --data-urlencode  "user=stahnma" \
 --data-urlencode  "url=http://www.section303.com" \
   http://giga2:4567/link

curl  -v \
 --data-urlencode  "user=stahnma" \
 --data-urlencode  "url=https://www.infoq.com/presentations/stripe-dev-env-infrastructure/ "\
   http://giga2:4567/link

curl  -v \
 --data-urlencode  "user=stahnma" \
 --data-urlencode  "url=http://twitter.com" \
   http://giga2:4567/link

curl  -v \
 --data-urlencode  "user=stahnma" \
 --data-urlencode  "url=http://example.com" \
   http://giga2:4567/link

curl  -v \
 --data-urlencode  "user=stahnma" \
 --data-urlencode  "url=http://countingcrows.com" \
   http://giga2:4567/link

curl -v \
 --data-urlencode  "user=somebody" \
 --data-urlencode  "url=https://twitter.com/adamhjk/status/1580728510347608064" \
   http://giga2:4567/link


# It should return the id of the link posted
# It should find the title
# If it's a 404, tell the user.
# If it's a 500 tell the user.
# It should validate SSL?
# If it has no title, fall back to url
# if it's a duplicate URI, return a snarky remark

