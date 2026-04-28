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
