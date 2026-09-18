# My Hyprland Dotfiles
My minimalistic and lightweight Hyprland config for Arch (incl. NVIDIA support) inspired by GNOME,
in a catppuccin mocha theme.

![Example of my rice](https://github.com/agustux/hyprland-dotfiles/blob/main/assets/2026-09-11-142304_hyprshot.png)

### Note:
Many of these packages will require an AUR helper (yay):
```
sudo pacman -S fakeroot debugedit
sudo pacman -Sy --needed --noconfirm git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
cd ../ && rm -rf yay-bin/
```
You can check out more on the Neovim setup included [here](https://github.com/agustux/nvim)

## Installation:
Add stub to .bashrc to load .config/bashrc:
```
echo '[ -f ~/.config/bash/bashrc ] && . ~/.config/bash/bashrc' > ~/.bashrc
```
Clearing bloat and possibly conflicting packages:
```
sudo pacman -Rns polkit-kde-agent wofi kwallet dolphin
```
Basic utils for Hyprland:
```
yay -S hyprland xdg-desktop-portal-gtk xdg-desktop-portal-hyprland hyprshutdown hyprpolkitagent \
hyprlock hypridle hyprpaper hyprshot wl-clipboard dunst adw-gtk-theme brightnessctl ghostty qt6ct \
qt6-wayland hyprqt6engine pipewire pipewire-pulse wireplumber baobab nautilus gnome-keyring loupe \
decibels showtime snapshot xorg-xhost
```
You may need to rebuild hyprpolkitagent for correct library versions or smth 

Quality-of-Life Packages:
```
yay -S curl vim neovim less man ufw rsync powertop nvtop lm_sensors cpupower fastfetch bat intel-undervolt bash-completion
```
More specific packages for my rice (fonts, waybar, and nvim):
```
yay -S ttf-dejavu ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols-mono ttf-nerd-fonts-symbols \
noto-fonts-emoji waybar rofi networkmanager-dmenu power-profiles-daemon pavucontrol rofi-bluetooth-git \
nm-connection-editor blueman tree-sitter-cli lua-language-server bash-language-server pyright clang

```
Graphics Stuff (NVIDIA libraries at bottom):
```
yay -S --needed --noconfirm mesa lib32-mesa vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader \
libdrm lib32-libdrm lib32-glibc lib32-gcc-libs lib32-libglvnd \
lib32-wayland lib32-libx11 lib32-libxcb lib32-libpulse lib32-libpipewire lib32-alsa-lib lib32-alsa-plugins \
intel-media-driver libva-intel-driver
```
Make these directories for Nautilus bookmarks:
```
mkdir $HOME/Documents
mkdir $HOME/Music
mkdir $HOME/Pictures
mkdir $HOME/Videos
mkdir $HOME/Downloads
```

Make for Hyprshot:
```
mkdir $HOME/Pictures/Screenshots
```

Should now be able to copy the contents of .config into your ~/.config:
```
cd $HOME && git clone https://github.com/agustux/hyprland-dotfiles.git
cp -r $HOME/hyprland-dotfiles/.config/. $HOME/.config/
```
Add proper gpu detection fix for bash_profile:
```
tee -a ~/.bash_profile > /dev/null << 'EOF'
# GPU detection for Hyprland/aquamarine (portable across machines)
GPUS=$(for f in /sys/bus/pci/devices/*/class; do
    read -r c < "$f"
    case "$c" in 0x030000|0x030200) basename "$(dirname "$f")" ;; esac
done)
IGPU_PCI=$(awk -F: '$2=="00"{print;exit}' <<< "$GPUS")
DGPU_PCI=$(awk -F: '$2!="00"{print;exit}' <<< "$GPUS")
[ -z "$IGPU_PCI" ] && { IGPU_PCI="$DGPU_PCI"; DGPU_PCI=""; }

if [ -n "$IGPU_PCI" ] && [ -n "$DGPU_PCI" ]; then
    mkdir -p "$HOME/.config/hypr"
    ln -sf "/dev/dri/by-path/pci-${IGPU_PCI}-card" "$HOME/.config/hypr/igpu-card"
    export AQ_DRM_DEVICES="$HOME/.config/hypr/igpu-card"
else
    rm -f "$HOME/.config/hypr/igpu-card"
    unset AQ_DRM_DEVICES
fi
```
And link the ly config in .config to /etc/ly:
```
sudo ln -sf "$HOME/.config/ly/config.ini" /etc/ly/config.ini
```

### NVIDIA-specific patches:
```
sudo systemctl enable nvidia-resume
sudo systemctl enable nvidia-suspend
sudo systemctl enable nvidia-hibernate

echo " loglevel=3 iommu=pt nvidia.NVreg_PreserveVideoMemoryAllocations=1 nvidia_drm.modeset=1" | sudo tee -a /etc/kernel/cmdline
sudo mkinitcpio -P

sudo tee /etc/modprobe.d/nvidia-pm.conf > /dev/null << 'EOF'
options nvidia NVreg_DynamicPowerManagement=0x02
options nvidia NVreg_EnableGpuFirmware=0
EOF

sudo tee /etc/udev/rules.d/80-nvidia-pm.rules > /dev/null << 'EOF'
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{remove}="1"
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{remove}="1"
ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{remove}="1"
ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="auto"
ACTION=="bind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="auto"
ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", TEST=="power/control", ATTR{power/control}="on"
ACTION=="unbind", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", TEST=="power/control", ATTR{power/control}="on"
EOF

sudo mkinitcpio -P

yay -S --needed --noconfirm nvidia-utils lib32-nvidia-utils nvidia-open-dkms
```
Credits to these dotfile repos, heavily influenced this one:
https://github.com/nadeemohc/dotfiles-hyprland-.git/
https://github.com/shivam-salkar/minimal-waybar-config.git/
