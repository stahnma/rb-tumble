

# A link with the channel
link=$(curl -s  \
 --data-urlencode  "user=test-user" \
 --data-urlencode  "url=https://www.youtube.com/watch?v=yslCUtpe_F8" \
 --data-urlencode "channel=#general" \
 $WEBURI/link)

curl -v -X DELETE \
	--data-urlencode "secret=ihasone" \
	$link

# A Link without a channel
link=$(curl -s  \
 --data-urlencode  "user=test-user" \
 --data-urlencode  "url=https://www.youtube.com/watch?v=yslCUtpe_F8" \
 $WEBURI/link)

curl -v -X DELETE \
	--data-urlencode "secret=ihasone" \
	$link

# Delete an invalid link
curl -v -X DELETE \
	--data-urlencode "secret=ihasone" \
	$WEBURI/link/121
# Delete a link posted long ago?
