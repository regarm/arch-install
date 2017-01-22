#!/bin/bash
set -e
# Any subsequent(*) commands which fail will cause the shell script to exit immediately
# The shell does not exit if the command that fails is part of the command list immediately following a while or until keyword, part of the test in an if statement, part of a && or || list, or if the command's return value is being inverted via !

echo 'This is a script to automate ARCH LINUX installation process.'
echo 'This assumes that you have done partition and are connected to internet.'

read -p 'Enter your root partition, (must): ' root
read -p 'Enter your swap partition, (if any): ' swap
read -p 'Enter your local repository, (if any): ' repo
read -p 'Enter your host name, (must): ' host
read -p 'Enter your user name, (must): ' user

echo "Following will be setup of your system after installation :"
echo "Root partition: $root"
if [ -z "$swap" ]; then
	echo "Swap partition: $swap"
fi
if [ -z "$repo" ]; then
echo "Local Repo: $repo"
fi
echo "Hostname: $host"
echo "Username: $user"

while [[ true ]]; do
	read -p "Are you sure to continue? : y/n" CONDITION;
	if [ "$CONDITION" == "y" ]; then
	   break
	fi
	if [ "$CONDITION" == "n" ]; then
		echo 'Exiting the script.'
		exit 1;
	fi
	echo "Please answer in y/n."
done

echo "Formating root partition"
umount $root
mkfs.ext4 $root

echo "Mounting root partition on /mnt"
mount $root /mnt

if [ -z "$swap" ]; then
	echo "Making swap on $swap"
	mkswap $swap
	swapon $swap
fi

echo "Done\n"