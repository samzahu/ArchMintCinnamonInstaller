#!/bin/bash
# Arch → Linux Mint Cinnamon Replica Installer
# Extended version with fonts, Cinnamon extensions, panel layout, keybindings, and Nemo defaults

set -e

echo "==> Installing reflector..."
sudo pacman -S --noconfirm reflector

echo "==> Optimizing mirrors with reflector..."
# Fetch the 30 most recently updated HTTPS mirrors worldwide,
# sort them by download rate, and save to pacman mirrorlist
sudo reflector --latest 30 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

echo "==> Refreshing package databases..."
sudo pacman -Syy

echo "==> Updating system..."
sudo pacman -Syu --noconfirm

echo "==> Installing Xorg + Cinnamon desktop..."
sudo pacman -S --noconfirm xorg xorg-xinit cinnamon cinnamon-session nemo gnome-terminal

echo "==> Installing LightDM + Slick Greeter..."
sudo pacman -S --noconfirm lightdm lightdm-slick-greeter
sudo systemctl enable lightdm.service --force

echo "==> Configuring LightDM Slick Greeter..."
sudo bash -c 'cat > /etc/lightdm/lightdm.conf <<EOF
[Seat:*]
greeter-session=lightdm-slick-greeter
user-session=cinnamon
EOF'

echo "==> Installing yay (AUR helper)..."
sudo pacman -S --noconfirm git base-devel
if ! command -v yay &> /dev/null; then
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si --noconfirm
fi

echo "==> Installing Mint themes, icons, and wallpapers..."
yay -S --noconfirm mint-themes mint-y-icons mint-x-icons mint-backgrounds

echo "==> Installing Mint default applications..."
yay -S --noconfirm xed pix xplayer hypnotix mintstick mintupdate

echo "==> Installing Mint fonts..."
yay -S --noconfirm fonts-linuxmint

echo "==> Installing Cinnamon extensions (Mint Menu, etc.)..."
yay -S --noconfirm cinnamon-spices-applets-mint-menu cinnamon-spices-applets-weather cinnamon-spices-applets-cpu-monitor

echo "==> Applying Cinnamon defaults..."
gsettings set org.cinnamon.desktop.interface gtk-theme "Mint-Y"
gsettings set org.cinnamon.desktop.interface icon-theme "Mint-Y"
gsettings set org.cinnamon.desktop.background picture-uri "file:///usr/share/backgrounds/linuxmint/default.jpg"

echo "==> Configuring Mint panel layout..."
gsettings reset-recursively org.cinnamon
gsettings set org.cinnamon panels-enabled "['1:bottom']"
gsettings set org.cinnamon panel-zone-icon-size '["1:0:24","1:1:24","1:2:24"]'
gsettings set org.cinnamon enabled-applets "['panel1:left:0:menu@cinnamon.org','panel1:left:1:show-desktop@cinnamon.org','panel1:center:0:window-list@cinnamon.org','panel1:right:0:systray@cinnamon.org','panel1:right:1:notifications@cinnamon.org','panel1:right:2:removable-drives@cinnamon.org','panel1:right:3:network@cinnamon.org','panel1:right:4:sound@cinnamon.org','panel1:right:5:power@cinnamon.org','panel1:right:6:calendar@cinnamon.org']"

echo "==> Configuring Mint keybindings..."
gsettings set org.cinnamon.desktop.keybindings.wm close "['<Alt>F4']"
gsettings set org.cinnamon.desktop.keybindings.wm minimize "['<Super>h']"
gsettings set org.cinnamon.desktop.keybindings.wm toggle-maximized "['<Super>Up']"
gsettings set org.cinnamon.desktop.keybindings.wm unmaximize "['<Super>Down']"
gsettings set org.cinnamon.desktop.keybindings.wm switch-to-workspace-left "['<Control><Alt>Left']"
gsettings set org.cinnamon.desktop.keybindings.wm switch-to-workspace-right "['<Control><Alt>Right']"
gsettings set org.cinnamon.desktop.keybindings.wm switch-to-workspace-up "['<Control><Alt>Up']"
gsettings set org.cinnamon.desktop.keybindings.wm switch-to-workspace-down "['<Control><Alt>Down']"

echo "==> Configuring Nemo defaults..."
# Single-click to open files
gsettings set org.nemo.preferences click-policy 'single'
# Default view: icon view
gsettings set org.nemo.preferences default-folder-viewer 'icon-view'
# Show location bar instead of path bar
gsettings set org.nemo.preferences show-location-entry true
# Show hidden files by default
gsettings set org.nemo.preferences show-hidden-files true
# Show toolbar with common actions
gsettings set org.nemo.preferences show-toolbar true
# Use Mint’s default zoom level
gsettings set org.nemo.icon-view default-zoom-level 'small'

echo "==> Installation complete!"
echo "Reboot your system to enjoy Arch with a Mint Cinnamon look and feel."

