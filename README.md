# hyprland-dotfiles
My minimalistic Hyprland config for Arch Linux (on NVIDIA) inspired by GNOME

### Note:
Many of these packages will require an AUR helper (yay).
```
sudo pacman -S fakeroot debugedit
sudo pacman -Sy --needed --noconfirm git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
cd ../ && rm -rf yay-bin/
```

## Installation:

Clearing bloat and possibly conflicting packages:
```
sudo pacman -Rns pokit-kde-agent wofi kwallet dolphin
```
Basic utils for Hyprland:
```
yay -S hyprland xdg-desktop-portal-gtk xdg-desktop-portal-hyprland hyprshutdown hyprpolkitagent hyprlock hypridle hyprpaper hyprshot wl-clipboard dunst adw-gtk-theme brightnessctl ghostty qt6ct qt6-wayland hyprqt6engine pipewire pipewire-pulse wireplumber baobab nautilus gnome-keyring loupe decibels showtime snapshot
```
You may need to rebuild hyprpolkitagent for correct library versions or smth 

Quality-of-Life Packages:
```
yay -S curl vim neovim less man ufw rsync powertop nvtop lm_sensors cpupower fastfetch bat intel-undervolt bash-completion
```
More specific packages for my rice (fonts and waybar):
```
yay -S tff-dejavu ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols-mono ttf-nerd-fonts-symbols noto-fonts-emoji waybar rofi networkmanager-dmenu power-profiles-daemon pavucontrol rofi-bluetooth-git nm-connection-editor blueman
```
Graphics Stuff:
```
yay -S --needed --noconfirm mesa lib32-mesa vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader libdrm lib32-libdrm nvidia-utils lib32-nvidia-utils nvidia-open-dkms lib32-glibc lib32-gcc-libs lib32-libglvnd lib32-wayland lib32-libx11 lib32-libxcb lib32-libpulse lib32-libpipewire lib32-alsa-lib lib32-alsa-plugins intel-media-driver libva-intel-driver
```

Should now be able to copy the contents of .config into your ~/.config

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

### NVIDIA-specific patches:
```
sudo systemctl enable nvidia-resume
sudo systemctl enable nvidia-suspend
sudo systemctl enable nvidia-hibernate

sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 intel_iommu=on iommu=pt nvidia.NVreg_PreserveVideoMemoryAllocations=1 nvidia_drm.modeset=1"/' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

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

mkdir -p ~/.config/hypr
IGPU_PCI=$(lspci -D | grep -i "VGA compatible controller: Intel" | head -1 | cut -d' ' -f1)
if [ -n "$IGPU_PCI" ]; then
  ln -sf "/dev/dri/by-path/pci-${IGPU_PCI}-card" ~/.config/hypr/igpu-card
fi

grep -qxF 'export AQ_DRM_DEVICES=$HOME/.config/hypr/igpu-card' ~/.bash_profile || \
  echo 'export AQ_DRM_DEVICES=$HOME/.config/hypr/igpu-card' >> ~/.bash_profile
```
May be required (according to the hyprland wiki), not necessary in my experience:
```
sudo sed -i 's/MODULES=.*/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
sudo mkinitcpio -P
```

![Example of my rice](https://github.com/agustux/hyprland-dotfiles/blob/main/assets/2026-04-24-231146_hyprshot.png)

Credits to these dotfile repos, heavily influenced this one:
https://github.com/nadeemohc/dotfiles-hyprland-.git/
https://github.com/shivam-salkar/minimal-waybar-config.git/
