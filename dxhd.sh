#!/bin/sh

## reload dxhd
# super + escape
dxhd -r

## launch kitty
# super + return
kitty

## launch lf
# super + f
kitty -e lf

## change wallpaper
# super + g
feh --randomize --no-fehbg --bg-fill '/home/cbirkmand/pix/wallpapers_dt'

## open screenshot menu
# print
flameshot gui

## opens browser
# super + b
brave

## opens emacs
# super + e
emacs

## Picom
# super + p
picom --experimental-backends -b

## Picom kill
# super + shift + p
killall picom
