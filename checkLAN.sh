#!/bin/bash/
while true; do clear; arp -alnx; c=$(arp -alnx | wc -l); let n=$c-1; printf '\tCount: \t'$n'\n'; sleep 2; done;
