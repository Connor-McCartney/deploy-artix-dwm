set -e



sudo pacman -S --noconfirm base-devel os-prober grub vlc htop git wget ripgrep fzf bat fd vim less git wget cmake

# compile yay
cd /tmp
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
printf "y\n" | makepkg -si


sudo pacman -S --noconfirm pavucontrol kitty thunar waterfox
#sudo pacman -S --noconfirm waterfox flameshot brave-bin discord obsidian flameshot sagemath thunar google-chrome

#sudo pacman -S --noconfirm xlibre-xserver      # i moved this to the pacstrap so that it's the very first thing
sudo pacman -S --noconfirm xorg-xinit xorg-xrandr
# xrandr --output Virtual-1 --mode 1920x1080






# add these if using a monitor
# xrandr --output LVDS-1 --off
# xrandr --output VGA-1 --auto

# xrandr --output Virtual-1 --mode 1920x1080 # hyperv

printf "#xrandr --output LVDS-1 --off\n#sleep 1\n#xrandr --output VGA-1 --auto\n\n# xrandr --output Virtual-1 --mode 1920x1080 # hyperv\nexec dwm" > /home/connor/.xsession # needed to boot with lightdm
chmod +x /home/connor/.xsession











# suckless
cd /tmp
git clone https://github.com/Connor-McCartney/deploy-artix-dwm
mv /tmp/deploy-artix-dwm/suckless /home/connor
cd /home/connor/suckless/dwm && sudo make clean install
cd /home/connor/suckless/dmenu && sudo make clean install
rm -rf /tmp/deploy-artix-dwm



# dotfiles
mkdir /home/connor/.local
mkdir /home/connor/.config
cd /tmp
wget https://raw.githubusercontent.com/Connor-McCartney/deploy-artix-dwm/refs/heads/main/dotfiles/install.sh
chmod +x install.sh
./install.sh






yay -S --noconfirm  noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-hack-nerd ttf-comic-mono-git
#yay -S --noconfirm brave-bin discord obsidian flameshot sagemath thunar google-chrome kitty
yay -S --noconfirm gvfs usbutils

# just for audio effect ('play file.mp3')
yay -S --noconfirm sox twolame libmad

# python setup
yay -S --noconfirm python-pip
python -m venv /home/connor/.p
/home/connor/.p/bin/python -m pip install --upgrade pip
/home/connor/.p/bin/pip install pycryptodome gmpy2 pwntools

# sage libs
#/usr/bin/sage --pip install pycryptodome pwntools --break-system-packages

# LSPs
yay -S --noconfirm clang pyright lua-language-server asm-lsp rust-analyzer # rust gets installed as a dependancy


# change gtk themes by running nwg-look
yay -S --noconfirm arc-gtk-theme
yay -S --noconfirm papirus-folders
papirus-folders -C magenta
yay -S --noconfirm kvantum nwg-look 

# file previews 
yay -S --noconfirm tumbler ffmpegthumbnailer libopenraw
