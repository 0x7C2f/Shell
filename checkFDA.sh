#!/bin/bash/
sudo sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db "SELECT client,allowed FROM access WHERE service == 'kTCCServiceSystemPolicyAllFiles'" | grep '1'$
