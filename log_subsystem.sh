#!/bin/bash/
ls -al /System/Library/Preferences/Logging/Subsystems | awk '{print $9}' | sed 's/.plist//g'
