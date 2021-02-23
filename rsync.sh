#!/bin/bash
echo "+ setting up mount point"
mkdir /var/tmp/Backup
sleep 2
echo "+ mounting..."
mount_smbfs //'KCTC-E546-09;filecopy':filecopy@172.22.125.80/Backup/ /var/tmp/Backup
Sleep 2
host="$(hostname)"
sudo mkdir /var/tmp/Backup/"${host}"
echo "Current Hostname: ${host}"
echo "+ Getting Users"
#userList="$(dscl . list /Users | grep -v -e '^_' -e 'root' -e 'nobody' -e 'daemon' -e 'AddigySSH')"
userList="$(ls /Users)"
echo "$userList"
sleep 2
for user in ""${userList[@]}""
do
    sleep 2
    echo "+ Copying data for $user"
    sudo rsync -rvP --exclude-from '/var/tmp/excludes.txt' /Users/${user} /var/tmp/Backup/"${host}"
done
sleep 5
umount /var/tmp/Backup
sleep 5
exit
