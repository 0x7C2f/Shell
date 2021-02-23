#!/bin/bash

USERNAME=btr
FULLNAME="btr user"
PASSWORD="btr"

SECONDARY_GROUPS="localaccounts"  # for a non-admin user
#SECONDARY_GROUPS="admin _lpadmin _appserveradm _appserverusr" # for an admin user


if [[ $UID -ne 0 ]]; then echo "Please run $0 as root." && exit 1; fi

# Find out the next available user ID
MAXID=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -ug | tail -1)
USERID=$((MAXID+1))

# Create the user account
sudo dscl . -create /Users/$USERNAME
sudo dscl . -create /Users/$USERNAME UserShell /bin/bash
sudo dscl . -create /Users/$USERNAME RealName "$FULLNAME"
sudo dscl . -create /Users/$USERNAME UniqueID "$USERID"
sudo dscl . -create /Users/$USERNAME PrimaryGroupID 20
sudo dscl . -create /Users/$USERNAME NFSHomeDirectory /Users/$USERNAME
sudo dscl . -passwd /Users/$USERNAME $PASSWORD


# Add use to any specified groups
for GROUP in $SECONDARY_GROUPS ; do
    sudo dseditgroup -o edit -t user -a $USERNAME $GROUP
done

# Create the home directory
sudo createhomedir -c > /dev/null
