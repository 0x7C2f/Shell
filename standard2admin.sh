#!/bin/bash

loggedInUser=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

if [ "$loggedInUser" == "" ]; then
    echo 'No logged-in user detected.'
    exit 1
else
    echo "$loggedInUser"
    if groups $loggedInUser | grep -q -w admin; then
        echo "Logged in user is already an admin."
        exit 1
    else
        sudo dscl . -append /groups/admin GroupMembership $loggedInUser
        sleep 2
        sudo dscl . -read /groups/admin GroupMembership
        echo "User is now an admin"
    fi
fi
