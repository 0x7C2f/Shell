sc config CrashPlanService start=auto

OR

/Applications/CrashPlan.app/Contents/Library/LaunchServices/CrashPlanService.app/Contents/Resources/bin/restart.sh





• Version 8.2 and later:
sudo launchctl unload /Library/LaunchDaemons/com.code42.service.plist
• Version 8.0 and earlier: sudo launchctl unload /Library/LaunchDaemons/com.crashplan.engine.plist
• 
• Version 8.2 and later:
sudo launchctl load /Library/LaunchDaemons/com.code42.service.plist
Version 8.0 and earlier: sudo launchctl load /Library/LaunchDaemons/com.crashplan.engine.plist
