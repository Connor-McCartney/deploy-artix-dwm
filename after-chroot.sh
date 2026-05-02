target="uefi-luks-hyperv"


set -e

ln -sf /usr/share/zoneinfo/Australia/Brisbane /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "artix" > /etc/hostname



if [[ $target -eq "uefi-luks-hyperv" ]]; then
    printf "MODULES=()\nBINARIES=()\nFILES=()\nHOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block encrypt lvm2 filesystems fsck)\n" > /etc/mkinitcpio.conf
    pacman -S --noconfirm thin-provisioning-tools lvm2
    mkinitcpio -p linux
    pacman -S efibootmgr --noconfirm; grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
    uuid=$(blkid -s UUID -o value /dev/sda2)
    printf "GRUB_TIMEOUT=1\nGRUB_DISTRIBUTOR=\"Artix\"\nGRUB_CMDLINE_LINUX=\"loglevel=1 nowatchdog cryptdevice=UUID="$uuid":cryptlvm root=/dev/vg1/root nvme_load=YES fsck.mode=skip modprobe.blacklist=iTCO_wdt\"\n" > /etc/default/grub
    grub-mkconfig -o /boot/grub/grub.cfg
fi


# connman is like NetworkManager
pacman -S connman-runit connman-gtk --noconfirm
ln -s /etc/runit/sv/connmand /etc/runit/runsvdir/default

#pacman -S connman-dinit connman-gtk --noconfirm
#dinitctl --offline enable connmand


# lightdm auto-login
pacman -S --noconfirm lightdm lightdm-runit
ln -s /etc/runit/sv/lightdm /etc/runit/runsvdir/default # like systemctl enable

#pacman -S --noconfirm lightdm lightdm-dinit
#dinitctl --offline enable lightdm

groupadd -r autologin
cd /usr/share
mkdir xsessions
cd xsessions
printf "[Desktop Entry]\nExec=/usr/bin/startx\n" > dwm.desktop
sed -i 's/'#autologin-user='/'autologin-user=connor'/g' /etc/lightdm/lightdm.conf
sed -i 's/'#autologin-session='/'autologin-session=dwm'/g' /etc/lightdm/lightdm.conf



useradd -m -G users,wheel,audio,video,autologin -s /bin/bash connor
printf " \n \n" | passwd
printf " \n \n" | passwd connor
echo -e "root ALL=(ALL:ALL) ALL\n%wheel ALL=(ALL:ALL) NOPASSWD: ALL\n@includedir /etc/sudoers.d" > /etc/sudoers

pacman -S --noconfirm wget
cd /home/connor
wget https://raw.githubusercontent.com/Connor-McCartney/deploy-artix-dwm/refs/heads/main/user.sh
chmod +x user.sh
sudo -u connor bash user.sh

#rm /after-chroot.sh
