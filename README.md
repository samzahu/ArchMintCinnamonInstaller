<h1 align="center">🌿 Arch → Linux Mint Cinnamon Replica Installer 🖥️</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Arch_Linux-blue?logo=arch-linux&logoColor=white" alt="Arch Linux">
  <img src="https://img.shields.io/badge/Desktop-Cinnamon-green?logo=linux&logoColor=white" alt="Cinnamon Desktop">
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT">
  <img src="https://img.shields.io/badge/Made%20with-Bash-lightgrey?logo=gnu-bash&logoColor=white" alt="Made with Bash">
  <img src="https://img.shields.io/badge/Uses-AUR-orange?logo=arch-linux&logoColor=white" alt="AUR Packages">
</p>

---

<p align="center">
  🖥️ Transform your Arch Linux into a <b>Linux Mint Cinnamon look‑alike</b> with one script.<br><br>
  🎨 Installs <b>Mint themes & icons</b><br>
  ⚙️ Configures <b>Cinnamon extensions</b><br>
  📁 Sets <b>Nemo defaults</b><br>
  ⌨️ Applies <b>Mint keybindings</b><br><br>
  🌿 Enjoy the full <b>Mint Cinnamon desktop experience</b> on Arch.
</p>

---

## ✨ Features

- 🎨 **Mint themes & icons**: Mint‑Y, Mint‑X, wallpapers  
- 🖥️ **Cinnamon desktop** with Mint panel layout  
- 🔑 **LightDM Slick Greeter** for login  
- 📦 **Mint default apps**: Xed, Pix, Xplayer, Hypnotix, Mintstick, Mintupdate  
- 🔤 **Fonts**: Mint’s default font set  
- ⚙️ **Cinnamon extensions**: Mint Menu, Weather, CPU Monitor  
- 📁 **Nemo defaults**: single‑click, icon view, hidden files visible, toolbar enabled  
- ⌨️ **Keybindings**: Super + arrows, Alt+F4, workspace shortcuts  

---

## 📦 Installation

Clone the repo and run the installer:

```bash
git clone https://github.com/samzahu/ArchMintCinnamonInstaller.git
cd ArchMintCinnamonInstaller
chmod +x install.sh
./install.sh
```

## 🛠️ Usage

After running the installer, your Arch system will be transformed into a **Mint Cinnamon desktop**. Here’s what you can do right away:

- 🎨 **Switch Themes**  
  Go to *System Settings → Themes* and choose **Mint‑Y** or **Mint‑X**.

- 📁 **Use Nemo File Manager**  
  Open Nemo (`nemo`) to enjoy Mint defaults: single‑click navigation, icon view, and toolbar enabled.

- 🖥️ **Explore Cinnamon Extensions**  
  Right‑click the panel → *Add Applets to Panel* → enable **Mint Menu**, **Weather**, and **CPU Monitor**.

- ⌨️ **Try Mint Keybindings**  
  - `Super + Arrow Keys` → move windows between workspaces  
  - `Alt + F4` → close window  
  - `Ctrl + Alt + Arrow Keys` → switch workspaces  

- 🔑 **Login Screen**  
  On reboot, you’ll see **LightDM Slick Greeter** styled like Linux Mint.

---

## 📸 Example Screenshots

<p align="center">
  <img src="screenshots/desktop.png" width="80%" alt="Mint Cinnamon Desktop on Arch"><br>
  <img src="screenshots/panel-layout.png" width="45%" alt="Panel Layout">
  <img src="screenshots/nemo.png" width="45%" alt="Nemo File Manager">
</p>

---

## 🛠️ Troubleshooting

### ⚠️ Common Issues & Fixes

- 🧩 **AUR packages not found**  
  Make sure you have an AUR helper installed (e.g., `yay` or `paru`).  
  ```bash
  sudo pacman -S yay
  ```
  Then rerun the installer.

- 🖥️ **Cinnamon desktop doesn’t start**  
  Ensure you’ve selected Cinnamon as your session in your login manager (LightDM).  
  If Cinnamon is missing, install manually:  
  ```bash
  sudo pacman -S cinnamon
  ```

- 🔑 **LightDM Slick Greeter not showing**  
  Verify LightDM is enabled and Slick Greeter is set:  
  ```bash
  sudo systemctl enable lightdm.service --force
  sudo systemctl start lightdm.service
  ```
  Check `/etc/lightdm/lightdm.conf` for `greeter-session=lightdm-slick-greeter`.

- 🎨 **Themes or icons not applied**  
  Open *System Settings → Themes* and manually select **Mint-Y** or **Mint-X**.  
  Sometimes Cinnamon defaults back to Adwaita — just reapply Mint themes.

- 📁 **Nemo not using Mint defaults**  
  Run Nemo once, then go to *Edit → Preferences* and confirm defaults (single‑click, icon view, toolbar).  
  The installer sets these, but they may reset if configs already exist.

- ⌨️ **Keybindings not working**  
  Go to *System Settings → Keyboard → Shortcuts* and check Mint defaults.  
  If conflicts exist, reset to defaults and reapply.

---

### 💡 Tips
- Always update your system before running the installer:  
  ```bash
  sudo pacman -Syu
  ```
- Reboot after installation to apply all changes.  
- If something breaks, check logs with:  
  ```bash
  journalctl -xe
  ```
---

## 🤝 Contributing Contributions are welcome!
- Fork the repo
- Create a feature branch
- Submit a pull request
