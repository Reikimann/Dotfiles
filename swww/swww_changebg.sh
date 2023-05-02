#!/usr/bin/env sh

WALLPAPER_DIR=~/pix/wall_pretty
WALLPAPER=$(fd --type=f . $WALLPAPER_DIR | shuf -n 1)

swww img $WALLPAPER \
  --transition-bezier .43,1.19,1,.4 \
  --transition-type grow \
  --transition-duration 1 \
  --transition-fps 90 \
  --transition-step 255 \
  --transition-pos top-right
