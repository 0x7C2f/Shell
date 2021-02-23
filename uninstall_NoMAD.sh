# /bin/bash
# Remove NoMad and use direct AD Bind

loggedInUser=`/bin/ls -l /dev/console | /usr/bin/awk ‘{ print $3 }'`

kill “NoMAD”
sudo rm -rf /Applications/NoMAD.app
sudo rm -rf “/Library/Managed Preferences/com.trusourcelabs.NoMAD.plist”
sudo rm -rf “/Library/Managed Preferences/$loggedInUser/com.trusourcelabs.NoMAD.plist”
sudo rm -rf “/Users/$loggedInUser/Library/LaunchAgents/com.trusourcelabs.NoMAD.plist”


mdfind -name "NoMAD"