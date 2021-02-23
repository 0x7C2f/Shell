#!/bin/bash
for i in $(/bin/ls /Library/Addigy | grep names.txt);
do
  echo "" > "/Library/Addigy/${i}"
done
/usr/bin/pkill pblock