#!/bin/bash

read -p 'Enter your host name, (must): ' host
read -p 'Enter your user name, (must): ' user
echo "Following information is provided by you :"

echo "Hostname: $host"
echo "Username: $user"

echo 'Setting locale en_US.UTF-8 UTF-8'
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
export LANG=en_US.UTF-8


echo 'Setting time zone to Asia/Calcutta'
ln -s /usr/share/zoneinfo/Asia/Calcutta /etc/localtime

echo 'Setting hardware clock (Generating /etc/adjtime )'
hwclock --systohc --utc

echo "Set Password for root account"
passwd

echo 'Setting host name'
echo $host > /etc/hostname
echo "127.0.0.1 localhost.localdomain $host" > /etc/hosts
echo "::1 localhost.localdomain $host" > /etc/hosts

echo "Setting Initial RamDisk Environment"
mkinitcpio -p linux

#Install BootLoader
echo "Install BootLoader"
pacman -S grub os-prober
grub-install --target=i386-pc --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo "Creating user"
useradd -m  -G users,audio,optical,storage,video,wheel,adm,games,scanner -s /bin/bash $user
passwd $user

echo "Setting allowance for use of sudo"
echo '#Manual Entry' >> /etc/sudoers
echo '%$user ALL=(ALL) ALL' >> /etc/sudoers

echo 'Exiting arch-chroot '
exit