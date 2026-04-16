#!/bin/bash

choice=$(printf "󰂅  Performance\n󰂀  Balanced\n󱈏  Power Saver" | \
    rofi -dmenu -i -p "Power Mode" \
    -theme-str 'element-text { font: "JetBrainsMono Nerd Font 18"; } listview { lines: 3; } window { width: 21%; }')

case "$choice" in
    *Performance*)
        powerprofilesctl set performance
        notify-send -t 2000 "Power Profile" "Set to Performance"
        ;;
    *Balanced*)
        powerprofilesctl set balanced
        notify-send -t 2000 "Power Profile" "Set to Balanced"
        ;;
    *Power\ Saver*)
        powerprofilesctl set power-saver
        notify-send -t 2000 "Power Profile" "Set to Power Saver"
        ;;
esac
