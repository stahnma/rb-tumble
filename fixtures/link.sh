#/usr/bin/env bash

curl  -v \
 --data-urlencode  "user=test-user" \
 --data-urlencode  "url=http://www.reddit.com" \
   $WEBURI/link

curl  -v \
 --data-urlencode  "user=test-user" \
 --data-urlencode  "url=http://www.section303.com" \
   $WEBURI/link

curl  -v \
 --data-urlencode  "user=test-user" \
 --data-urlencode  "url=https://www.infoq.com/presentations/stripe-dev-env-infrastructure/ "\
   $WEBURI/link

curl  -v \
 --data-urlencode  "user=test-user" \
 --data-urlencode  "url=http://twitter.com" \
   $WEBURI/link

curl  -v \
 --data-urlencode  "user=test-user" \
 --data-urlencode  "url=http://example.com" \
   $WEBURI/link

curl  -v \
 --data-urlencode  "user=test-user" \
 --data-urlencode  "url=http://countingcrows.com" \
   $WEBURI/link

curl -v \
 --data-urlencode  "user=test-user" \
 --data-urlencode  "url=https://twitter.com/adamhjk/status/1580728510347608064" \
   $WEBURI/link

curl -v \
 --data-urlencode  "user=test-user" \
 --data-urlencode  "url=https://youtu.be/yslCUtpe_F8" \
   $WEBURI/link

curl -v \
 --data-urlencode  "user=test-user" \
 --data-urlencode  "url=https://www.youtube.com/watch?v=yslCUtpe_F8" \
 --data-urlencode "channel=#general" \
   $WEBURI/link


link=(curl -v \
 --data-urlencode  "user=test-user" \
 --data-urlencode  "url=https://www.youtube.com/watch?v=yslCUtpe_F8" \
 --data-urlencode "channel=#general" \
 $WEBURI/link)
echo $link


# It should return the id of the link posted
# It should find the title
# If it's a 404, tell the user.
# If it's a 500 tell the user.
# It should validate SSL?
# If it has no title, fall back to url
# if it's a duplicate URI, return a snarky remark

