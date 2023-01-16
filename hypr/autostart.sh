#!/usr/bin/env sh

# Stars dunst
dunst &

# Sets cursor theme
hyprctl setcursor Breeze_Snow 16

# https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
# Sets cursor theme in gtk apps
gsettings set org.gnome.desktop.interface cursor-theme "$(grep 'gtk-cursor-theme-name' ~/.config/gtk-3.0/settings.ini | sed 's/.*\s*=\s*//')"
