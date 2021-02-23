#!/bin/bash
# Variables
appTitle=("Microsoft Word.app" "Microsoft PowerPoint.app" "Microsoft Excel.app" "Microsoft Outlook.app" "Microsoft OneNote.app")
# Used to decide which versions will be checked
versionList=("16.30" "16.31" "16.32" "16.33" "16.34" "16.35" "16.36")
# Update looop
for u in "${appTitle[@]}"
do
	ProcessID=$(ps aux | grep "$u" | awk '{print $2}' | head -1)
	AppVersion="$(/usr/libexec/PlistBuddy -c 'Print CFBundleShortVersionString' /Applications/"$u"/Contents/Info.plist)"
# Modify the != to decide whether or not you WANT the versions included in the Version List.
	if [[ " ${versionList[@]} " != "$AppVersion" ]]; then
		echo "You have the correct version of "$u" installed!"
	else
		echo "Current "$u" Version is: "$AppVersion >> DEPNotify.log
		echo ""$u" should be installed..." >> DEPNotify.log
		echo "Applying Changes Now..." >> DEPNotify.log
		kill $ProcessID
		cd /Applications && sudo rm -rf "$u" && sudo /usr/local/munki/managedsoftwareupdate && sudo /usr/local/munki/managedsoftwareupdate --installonly
	fi
done
