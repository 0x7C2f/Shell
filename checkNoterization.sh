#!/bin/bash/
for i in /Applications/* ; do stapler validate "${i}"|grep -B 1 -v worked;done
