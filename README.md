# My Hyprland Dotfiles
My minimalistic and lightweight Hyprland config for Arch with NVIDIA support(incl. 580 devices if needed), in Catppuccin Mocha.
Config is in hyprland.lua, includes runtime hardware detection (display outputs, GPU driver, undervolt support)
instead of hardcoded values, so the same dotfiles port across different machines.
Laptop battery life is priority, so power tooling (tlp, power-profiles-daemon, intel-undervolt) is included

### Requirements:
- Arch Linux
- Internet connection
- A supported (clean) Hyprland environment

This should preferably run after a clean arch install

### Quickstart:
```
bash -c "$(curl -fsSL https://raw.githubusercontent.com/agustux/hyprland-dotfiles/main/install.sh)"
```
Flags:
- `--nvidia`  Install NVIDIA drivers/config
- `--bloat`   Install Gus-curated extra tools and utilities

The installer may modify your system configuration and will install
packages. Review install.sh before running it if you want to see exactly
what will be changed.

![Example of my rice](https://github.com/agustux/hyprland-dotfiles/blob/main/assets/2026-09-11-142304_hyprshot.png)
