#! /bin/bash

####
# input parameters: silent_install.sh <application_identifier> <application_name> <preference_pane_name> <keep_config>
#
# example: silent_uninstall.sh com.datto.dfp "Datto File Protection" dfpPreferencePane 1
# example: silent_uninstall.sh com.datto.dwp "Datto Workplace Desktop" dwpPreferencePane 1
#
# <application_identifier> is applicaiton identifier. For File Protection: com.datto.dfp. For Workplace: com.datto.dwp
# <application_name> is name of application to delete. For Workplace, it is “Datto Workplace Desktop”. For File Protection, it is "Datto File Protection"
# <preference_pane_name> is name of preference pane of application. For File Protection: com.datto.dfp. For Workplace: com.datto.dwp
# 
#
# Script needs correct execution permissions and must be run as sudo
#
####

TestZero()
{
	ret=$?
	if [ $ret -ne 0 ]; then
		echo "ERROR during installation: $ret"
		exit $ret
	fi
}

if test -z "$1" || test -z "$2" || test -z "$3" || test -z "$4"; then
	echo "All input parameters are mandatory"
	exit
fi

APPLICATION_NAME="$2"
APPLICATION_IDENTIFIER="$1"
TEAMKEY_PATH="/Library/Preferences/${APPLICATION_IDENTIFIER}.teamkey"
SILENT_INSTALLER_TARGET_PATH="/Library/LaunchAgents/${APPLICATION_IDENTIFIER}.installer.plist"

#kill application
killall "${APPLICATION_NAME}" 2>/dev/null

#kill account setup
killall "AccountSetup" 2>/dev/null

#kill system preferences
killall "System Preferences" 2>/dev/null

#delete application
echo "Deleting application..."
rm -rf "/Applications/${APPLICATION_NAME}.app"
TestZero
echo "Done delete"

#delete config and prefpane
for user in $(dscl . list /Users | grep -v false | grep "^[^_]")
do
	if [ "$4" -ne 1 ]; then
		if [ -d "/Users/${user}/Library/Preferences/${APPLICATION_IDENTIFIER}" ]; then
			echo "Deleting configuration..."
			rm -rf "/Users/${user}/Library/Preferences/${APPLICATION_IDENTIFIER}"
			TestZero
			echo "Configuration deleted at path: /Users/${user}/Library/Preferences/${APPLICATION_IDENTIFIER}"
			echo "Removing Datto Workplace Directory"
			rm -rf "/Users/${user}/Datto Workplace/"
		fi
	fi

	if [ -d "/Users/${user}/Library/PreferencePanes/$3.prefPane" ]; then
		echo "Deleting preference pane"
		rm -rf "/Users/${user}/Library/PreferencePanes/$3.prefPane"
		TestZero
		echo "Preference pane deleted for user: ${user}"
		echo "Removing Datto Workplace Directory"
		rm -rf "/Users/${user}/Datto Workplace/"
	fi

	#delete startup item
	if [ -f "/Users/${user}/Library/LaunchAgents/${APPLICATION_IDENTIFIER}.loginItem.plist" ]; then
		echo "Deleting loginItem..."
		rm -f "/Users/${user}/Library/LaunchAgents/${APPLICATION_IDENTIFIER}.loginItem.plist"
		TestZero
		echo "Deleted loginItem for user ${user}"
		echo "Removing Datto Workplace Directory"
		rm -rf "/Users/${user}/Datto Workplace/"
	fi
done

#delete teamkey
echo "Deleting teamkey..."
rm -rf "${TEAMKEY_PATH}"
TestZero
echo "TeamKey deleted"

#unload silent installer
echo "Unloading silent_installer..."
launchctl unload "${SILENT_INSTALLER_TARGET_PATH}"
TestZero
echo "Silent installer unloaded"

#delete silent_installer 
echo "Deleting silent installer..."
rm -rf "${SILENT_INSTALLER_TARGET_PATH}"
TestZero
echo "Silent installer deleted"

# delete (6.0-AEB) AEB installer plist
rm -f "/Library/LaunchAgents/com.autotask.installer.plist"
echo "Removing Datto Workplace Directory"
rm -rf "/Users/${user}/Datto Workplace/"

echo "Uninstall finished successfully"
exit 0
