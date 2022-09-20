#!/usr/bin/sh


# Start picom
#picom --experimental-backends

# Swaps control key and capslock
setxkbmap -option "ctrl:swapcaps"

# Launches dxhd
dxhd -b

# Launches polybar
~/.config/polybar/launch.sh &

# Draws background
feh --randomize --no-fehbg --bg-fill "/home/reikimann/pix/wallpapers"

# Stars dunst
dunst &

~/.local/bin/host-check &
