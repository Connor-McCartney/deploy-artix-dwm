target="uefi-luks-hyperv"


################
swapoff /dev/*
umount /dev/*
set -e



if [[ $target -eq "uefi-luks-hyperv" ]]; then"
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


sv up openntpd
