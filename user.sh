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






# add these if using a monitor
# xrandr --output LVDS-1 --off
# xrandr --output VGA-1 --auto

# xrandr --output Virtual-1 --mode 1920x1080 # hyperv

printf "#xrandr --output LVDS-1 --off\n#sleep 1\n#xrandr --output VGA-1 --auto\n\n# xrandr --output Virtual-1 --mode 1920x1080 # hyperv\nexec dwm" > /home/connor/.xsession # needed to boot with lightdm
chmod +x /home/connor/.xsession
