set -e


# Paru
cd /tmp
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si --noconfirm


# packages

sudo pacman -S --noconfirm base-devel os-prober grub vlc htop git wget ripgrep fzf bat fd vim less 

sudo pacman -S --noconfirm pavucontrol kitty thunar waterfox
#sudo pacman -S --noconfirm waterfox flameshot brave-bin discord obsidian flameshot sagemath thunar google-chrome

sudo pacman -S --noconfirm xlibre-xserver
sudo pacman -S --noconfirm xorg-xinit xorg-xrandr
# xrandr --output Virtual-1 --mode 1920x1080
