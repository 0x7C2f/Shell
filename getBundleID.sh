#!/bin/bash/
# Method One
lsappinfo list | grep <appname>
# Method Two
grep -A1 -i bundleidentifier "$(mdfind -name <appname>.app | head -n 1)"/Contents/Info.plist
