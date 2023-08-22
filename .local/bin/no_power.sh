#!/bin/sh

cap=$(tail /sys/class/power_supply/BAT1/capacity)

notify-send "On Battery" "Capacity is at ${cap}%"
