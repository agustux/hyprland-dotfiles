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
yay -S hyprland xdg-desktop-portal-gtk xdg-desktop-portal-hyprland hyprshutdown hyprpolkitagent hyprlauncher hyprlock hypridle hyprpaper hyprshot wl-clipboard brightnessctl ghostty qt6ct qt6-wayland hyprqt6engine pipewire pipewire-pulse wireplumber baobab nautilus gnome-keyring loupe decibels showtime snapshot
```
Quality-of-Life Packages:
```
yay -S curl vim neovim less man ufw rsync powertop nvtop lm_sensors cpupower fastfetch bat intel-undervolt bash-completion
```
More specific packages for my rice (fonts and waybar):
```
yay -S tff-dejavu ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols-mono ttf-nerd-fonts-symbols noto-fonts-emoji waybar rofi networkmanager-dmenu power-profiles-daemon pavucontrol rofi-bluetooth-git nm-connection-editor blueman
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
