#!/bin/sh

## reload dxhd
# super + escape
dxhd -r

## launch kitty
# super + return
kitty

## Volume up
# super + up
amixer -D pulse sset Master 5%+ unmute

## Volume down
# super + down
amixer -D pulse sset Master 5%- unmute

## Volume toggle
# super + right
amixer -D pulse sset Master toggle

# super + f
kitty -e lf

## change wallpaper
# super + g
feh --randomize --no-fehbg --bg-fill '/home/reikimann/pix/wallpapers'

## open screenshot menu
# print
flameshot gui

## opens discord
# super + d
discord

## opens firefox
# super + b
waterfox-g4

## opens rofi
# super + y
rofi -show run

## opens emacs
# super + e
emacs

## opens emacs
# super + s
spotify

## Picom
# super + p
picom --experimental-backends -b

## Picom kill
# super + shift + p
killall picom
