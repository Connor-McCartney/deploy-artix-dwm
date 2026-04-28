target="uefi-luks-hyperv"


################
swapoff /dev/*
umount /dev/*
set -e



if [[ $target -eq "uefi-luks-hyperv" ]]; then
    ...
fi
