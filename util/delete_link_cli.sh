#!/bin/bash


# Delete an invalid link
curl -v -X DELETE \
	--data-urlencode "secret=ihasone" \
	$WEBURI/link/$1

