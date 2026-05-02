#target="uefi-luks-hyperv"
target="bios-thinkpad"


################
swapoff /dev/*
umount /dev/*
set -e



if [[ $target -eq "uefi-luks-hyperv" ]]; then
    printf "g\nn\n1\n\n+256M\nt\n1\nn\n2\n\n\nw\n" | fdisk /dev/sda
    cryptsetup luksFormat /dev/sda2
    cryptsetup open /dev/sda2 cryptlvm
    pvcreate /dev/mapper/cryptlvm
    vgcreate vg1 /dev/mapper/cryptlvm
    lvcreate -L 8G vg1 -n swap
    lvcreate -l 100%FREE vg1 -n root
    mkfs.vfat -F 32 /dev/sda1
    mkfs.ext4 /dev/vg1/root
    mkswap /dev/vg1/swap
    mount /dev/vg1/root /mnt
    mkdir /mnt/boot
    mount /dev/sda1 /mnt/boot
    swapon /dev/vg1/swap
fi


if [[ $target -eq "bios-thinkpad" ]]; then
    printf "o\nn\n\n\n\n+8G\nn\n\n\n\n\nt\n1\n82\na\n2\nw\n" | fdisk /dev/sda  
    mkswap /dev/sda1
    mkfs.ext4 /dev/sda2
    mount /dev/sda2 /mnt
    swapon /dev/sda1
fi



#sv up openntpd (runit)
# dinitctl start ntpd (dinit)

#basestrap /mnt base base-devel runit elogind-runit
basestrap /mnt base base-devel dinit elogind-dinit
basestrap /mnt linux linux-firmware linux-firmware-intel xlibre-xserver cryptsetup grub wget
fstabgen -U /mnt >> /mnt/etc/fstab



cd /mnt
wget https://raw.githubusercontent.com/Connor-McCartney/deploy-artix-dwm/refs/heads/main/after-chroot.sh
cat after-chroot.sh | artix-chroot /mnt
#reboot
