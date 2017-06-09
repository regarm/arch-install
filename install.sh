#!/bin/bash

echo "Arch Install Script"

#Warning
cat lib/disclaimer.md
echo 'Press any key to continue or ctrl+c to exit'
read



read -p 'Enter your root partition, (must): '  ais_ROOT
read -p 'Enter your swap partition, (if any): ' ais_SWAP
read -p 'Enter your local mirror, (if any): ' ais_mirror

echo "Following information is provided by you: "
echo "Root partition: $root"
if [ ! -z "$swap" ]; then
	echo "Swap partition: $swap"
fi
if [ ! -z "$mirror" ]; then
echo "Local Repo: $mirror"
fi

while [[ true ]]; do
	read -p "Are you sure to continue? [y/n]" CONDITION;
	if [ "$CONDITION" == "y" ]; then
	   break
	fi
	if [ "$CONDITION" == "n" ]; then
		echo 'Exiting the script.'
		exit 1;
	fi
	echo "Please answer in [y/n]."
done

echo "Update system clock"
timedatectl set-ntp true

echo "Formating root partition"
set +e
umount $root
set -e
mkfs.ext4 $root

echo "Mounting root partition on /mnt"
mount $root /mnt

if [ ! -z "$swap" ]; then
	set +e
	echo "Making swap on $swap"
	mkswap $swap
	swapon $swap
	set -e
fi

if [ ! -z "$mirror" ]; then
	echo "Adding following mirror to mirrorlist : $mirror"
	echo "Server = $mirror" > /etc/pacman.d/mirrorlist.insnew
	cat /etc/pacman.d/mirrorlist >> /etc/pacman.d/mirrorlist.insnew
	cat /etc/pacman.d/mirrorlist.insnew > /etc/pacman.d/mirrorlist
fi

#Fetching Arch linux PGP keyring
pacman -S archlinux-keyring

#Installing Base System
echo 'Installing Base System'
pacstrap -i /mnt base base-devel

#Generating fstab
echo 'Generating fstab'
genfstab -U -p /mnt >> /mnt/etc/fstab


echo 'Copying inside job'
cp ./insidejob.sh /mnt/usr/bin

#doing arch-chroot
arch-chroot /mnt insidejob.sh

echo "Successfull"
