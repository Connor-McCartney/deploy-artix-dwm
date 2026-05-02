set -e

cd /tmp
git clone https://github.com/Connor-McCartney/deploy-artix-dwm


mv /tmp/deploy-artix-dwm/dotfiles/.config/gtk-3.0 /home/connor/.config
mv /tmp/deploy-artix-dwm/dotfiles/.config/kitty /home/connor/.config
mv /tmp/deploy-artix-dwm/dotfiles/.config/nvim /home/connor/.config
mv /tmp/deploy-artix-dwm/dotfiles/.config/picom /home/connor/.config
mv /tmp/deploy-artix-dwm/dotfiles/.bashrc /home/connor
mv /tmp/deploy-artix-dwm/dotfiles/.fdignore /home/connor
mv /tmp/deploy-artix-dwm/dotfiles/pyproject.toml /home/connor
mv /tmp/deploy-artix-dwm/dotfiles/.wallpapers /home/connor

mv /tmp/deploy-artix-dwm/dotfiles/.switcher.sh /home/connor
mv /tmp/deploy-artix-dwm/dotfiles/.vim_saver.sh /home/connor
mv /tmp/deploy-artix-dwm/dotfiles/.xsage.sh /home/connor
mv /tmp/deploy-artix-dwm/dotfiles/.upvol.sh /home/connor
mv /tmp/deploy-artix-dwm/dotfiles/.downvol.sh /home/connor

mv /tmp/deploy-artix-dwm/dotfiles/.volume_change.mp3 /home/connor

chmod +x /home/connor/.switcher.sh /home/connor/.xsage.sh /home/connor/.vim_saver.sh /home/connor/.upvol.sh /home/connor/.downvol.sh

rm -rf /tmp/deploy-artix-dwm
