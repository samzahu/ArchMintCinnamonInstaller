#!/bin/bash
# Arch → Linux Mint Cinnamon Replica Installer
# Extended version with fonts, Cinnamon extensions, panel layout, keybindings, and Nemo defaults

set -e

echo "==> Updating system..."
sudo pacman -Syu --needed --noconfirm

echo "==> Installing Xorg + Cinnamon desktop..."
sudo pacman -S --needed --noconfirm xorg xorg-xinit cinnamon cinnamon-session nemo gnome-terminal

echo "==> Installing LightDM + Slick Greeter..."
sudo pacman -S --needed --noconfirm lightdm lightdm-slick-greeter
sudo systemctl enable lightdm.service --force

echo "==> Configuring LightDM Slick Greeter..."
sudo bash -c 'cat > /etc/lightdm/lightdm.conf <<EOF
[Seat:*]
greeter-session=lightdm-slick-greeter
user-session=cinnamon
EOF'

echo "==> Installing yay (AUR helper)..."
sudo pacman -S --needed --noconfirm git base-devel
if ! command -v yay &> /dev/null; then
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si --noconfirm
fi

echo "==> Installing Mint themes, icons, and wallpapers..."
yay -S --needed --noconfirm mint-themes mint-y-icons mint-x-icons mint-backgrounds

echo "==> Installing Mint default applications..."
yay -S --needed --noconfirm xed pix xplayer hypnotix mintstick mintupdate

echo "==> Installing Mint fonts..."
yay -S --needed --noconfirm fonts-linuxmint

echo "==> Installing Cinnamon extensions (Mint Menu, etc.)..."
yay -S --needed --noconfirm cinnamon-spices-applets-mint-menu cinnamon-spices-applets-weather cinnamon-spices-applets-cpu-monitor

echo "==> Installing Snap"
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si

echo "==> Installing Snap"
sudo pacman -S --needed --noconfirm flatpak

echo "==> Installing Pamac-Full (GUI App Store with Flatpak + Snap support)..."
yay -S --needed --noconfirm pamac-full

echo "==> Enabling Snap service..."
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap || true

echo "==> Adding Flathub remote for Flatpak..."
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "==> Creating default .xinitrc for Cinnamon..."
cat > ~/.xinitrc <<EOF
exec cinnamon-session
EOF

echo "==> Pre-seeding dconf with Mint Cinnamon defaults..."
mkdir -p /etc/dconf/db/local.d

sudo bash -c 'cat > /etc/dconf/db/local.d/00-mint-settings <<EOF
[org/cinnamon/desktop/interface]
gtk-theme="Mint-Y"
icon-theme="Mint-Y"

[org/cinnamon/desktop/background]
picture-uri="file:///usr/share/backgrounds/linuxmint/default.jpg"

[org/cinnamon]
panels-enabled=["1:bottom"]
panel-zone-icon-size=["1:0:24","1:1:24","1:2:24"]
enabled-applets=["panel1:left:0:menu@cinnamon.org","panel1:left:1:show-desktop@cinnamon.org","panel1:center:0:window-list@cinnamon.org","panel1:right:0:systray@cinnamon.org","panel1:right:1:notifications@cinnamon.org","panel1:right:2:removable-drives@cinnamon.org","panel1:right:3:network@cinnamon.org","panel1:right:4:sound@cinnamon.org","panel1:right:5:power@cinnamon.org","panel1:right:6:calendar@cinnamon.org"]

[org/cinnamon/desktop/keybindings/wm]
close=["<Alt>F4"]
minimize=["<Super>h"]
toggle-maximized=["<Super>Up"]
unmaximize=["<Super>Down"]
switch-to-workspace-left=["<Control><Alt>Left"]
switch-to-workspace-right=["<Control><Alt>Right"]
switch-to-workspace-up=["<Control><Alt>Up"]
switch-to-workspace-down=["<Control><Alt>Down"]

[org/nemo/preferences]
click-policy="single"
default-folder-viewer="icon-view"
show-location-entry=true
show-hidden-files=true
show-toolbar=true

[org/nemo/icon-view]
default-zoom-level="small"
EOF'

sudo dconf update

echo "==> Installation complete!"
echo "Reboot your system to enjoy Arch with a Mint Cinnamon look and feel."

