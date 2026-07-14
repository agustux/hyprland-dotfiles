#!/bin/bash

choice=$(printf "⏻  Shutdown\n  Reboot\n󰍃  Suspend\n󰌾  Lock" | \
    rofi -dmenu -i -p "Power" \
    -theme-str 'element-text { font: "JetBrainsMono Nerd Font 15"; }
                listview { lines: 4; }
                window { width: 21%; }')

case "$choice" in
    *Shutdown*) systemctl poweroff ;;
    *Reboot*) systemctl reboot ;;
    *Suspend*) hyprctl dispatch exit ;;
    *Lock*) hyprlock ;;
esac
