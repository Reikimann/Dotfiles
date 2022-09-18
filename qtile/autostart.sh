#!/bin/bash


# Start picom
#picom --experimental-backends

# Swaps control key and capslock
setxkbmap -option "ctrl:swapcaps"

# Enable tapping
xinput set-prop 10 316 1

# Enable tapping
xinput set-prop 10 308 1

# Launches dxhd
dxhd -b

# Launches polybar
~/.config/polybar/launch.sh

# Draws background
feh --randomize --no-fehbg --bg-fill "/home/reikimann/pix/wallpapers"

# Stars dunst
dunst &

~/.local/bin/host-check
