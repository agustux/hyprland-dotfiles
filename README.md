# hyprland-dotfiles
My Minimalistic Hyprland Config for Arch Linux (on NVIDIA)

### Note:
Many of these packages will require an AUR helper (yay).
```
sudo pacman -S fakeroot debugedit
sudo pacman -Sy --needed --noconfirm git base-devel && git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
cd ../ && rm -rf yay-bin/
```

## Installation:
```
# clearing bloat:
yay -Rns pokit-kde-agent wofi kwallet dolphin

# basic utils for hyprland:
yay -S xdg-desktop-portal-gtk xdg-desktop-portal-hyprland hyprshutdown hyprpolkitagent hyprlauncher hyprlock hypridle hyprpaper hyprshot wl-clipboard brightnessctl ghostty qt6ct qt6-wayland hyprqt6engine pipewire pipewire-pulse wireplumber

# more specific packages for my rice:
yay -S tff-dejavu ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols-mono ttf-nerd-fonts-symbols curl vim neovim less man ufw rsync powertop nvtop lm_sensors cpupower fastfetch bat noto-fonts-emoji intel-undervolt bash-completion baobab nautilus gnome-keyring

# waybar packages:
yay -S waybar rofi networkmanager-dmenu power-profiles-daemon pavucontrol rofi-bluetooth-git nm-connection-editor blueman

# NVIDIA stuff #################################
sudo systemctl enable nvidia-resume
sudo systemctl enable nvidia-suspend
sudo systemctl enable nvidia-hibernate

sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 intel_iommu=on iommu=pt nvidia.NVreg_PreserveVideoMemoryAllocations=1"/' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

#sudo sed -i 's/MODULES=.*/MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)/' /etc/mkinitcpio.conf
#sudo mkinitcpio -P

################################################
```
