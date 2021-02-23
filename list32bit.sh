#!/bin/bash
/usr/bin/mdfind "kMDItemContentType == 'com.apple.application-bundle' && kMDItemExecutableArchitectures != '*x86_64*'"

OR

system_profiler SPApplicationsDataType | grep -B 6 -A 2 "(Intel): No".

OR

system_profiler SPLegacySoftwareDataType -detailLevel mini -xml [PATH YOU WANT]

