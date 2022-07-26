#!/bin/sh

## Reload dxhd
# super + escape
dxhd -r

## Launch kitty
# super + return
kitty

## Volume up/down
# super + {up,down}
amixer -D pulse sset Master {5%+,5%-} unmute

## Volume toggle
# super + right
amixer -D pulse sset Master toggle

## Music prev/next
# super + shift + {left,right}
playerctl -p spotify {previous,next}

## Music play/pause
# super + shift + space
playerctl -p spotify play-pause

## Opens lf
# super + f
kitty -e lf

## Change wallpaper
# super + g
feh --randomize --no-fehbg --bg-fill '/home/reikimann/pix/wallpapers'

## Open screenshot menu
# print
flameshot gui

## Opens discord
# super + d
discord

## Opens browser
# super + b
waterfox-g4

## Opens rofi
# super + y
rofi -show run

## Opens emacs
# super + e
emacs

## Opens emacs
# super + s
spotify

## Picom
# super + p
picom --experimental-backends -b

## Picom kill
# super + shift + p
killall picom
