#!/bin/bash/
# Method One
ioreg -rd1 -c IOPlatformExpertDevice | grep UUID | awk '{print $NF}' | sed 's/\"//g'
# Method Two
/usr/sbin/system_profiler SPHardwareDataType | grep UUID | awk '{print $NF}'
