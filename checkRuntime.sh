#!/bin/bash/
for i in /Applications/*.app; do codesign -dv "${i}" &>> /tmp/codes; done; grep -B3 'none' /tmp/codes | grep ^Executable | sed 's/^Executable=/No\ Hardened\ Runtime:\ /g'; rm -rf /tmp/codes
