#!/usr/bin/env sh

# Set wallpaper dir
export RICE_WALL_DIR=~/pix/rices/tokyonight

# Starts Wallpaper Deamon
# swww init

# Randomizes wallpapers (This now inits daemon)
~/.config/swww/swww_randomize.sh $RICE_WALL_DIR &

# Sets Cursor Theme
hyprctl setcursor Breeze_Snow 16

# https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
# Sets cursor theme in gtk apps
gsettings set org.gnome.desktop.interface cursor-theme "$(grep 'gtk-cursor-theme-name' ~/.config/gtk-3.0/settings.ini | sed 's/.*\s*=\s*//')"

# Start Waybar
waybar &

# Stars Dunst
dunst &

# Starts the NetworkManager applet
nm-applet 2>&1 > /dev/null &

# Manage Lockscreen
~/.local/bin/lockidle &

# Manage Nightlight
wlsunset -S 7:50 -s 19:30 &

# Manage Clipboard
wl-paste -t text --watch clipman store --no-persist &
