#!/bin/bash

# Stars dunst
dunst &

# Starts network manager
nm-applet &

# Sets cursor theme
hyprctl setcursor breeze 16
