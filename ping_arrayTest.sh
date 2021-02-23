#!/bin/bash
serverList=("gg.apple.com"
"gnf-mdn.apple.com"
"gnf-mdr.apple.com"
"ig.apple.com"
"mesu.apple.com"
"oscdn.apple.com"
"osrecovery.apple.com"
"skl.apple.com"
"swcdn.apple.com"
"swdist.apple.com"
"swdownload.apple.com"
"swpost.apple.com"
"swscan.apple.com"
"updates-http.cdn.apple.com"
"updates.cdn.apple.com"
"xp.apple.com"	
)

for server in "${serverList[@]}"
do
  	ping -c30 "${server}"

  	if [ $? -eq 0 ];
  	then
  		echo "$server is accessible"
  		successfulList=($server)
  		echo "${successfulList[@]}"
    else
    	echo "$server failed to ping"
    	failedList+=($server)
  	fi
done
