set -e

sudo pacman -S --noconfirm base-devel os-prober grub vlc htop git wget ripgrep fzf bat fd vim less pavucontrol
sudo pacman -S --noconfirm kitty waterfox

sudo pacman -S --noconfirm xlibre-xserver
sudo pacman -S --noconfirm xorg-xinit xorg-xrandr
# xrandr --output Virtual-1 --mode 1920x1080
