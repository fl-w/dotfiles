#!/bin/sh

xrandr --output DP-1 --mode 1920x1080 --pos 2560x0 --rotate right --output DP-2 --off --output DP-3 --off --output HDMI-1 --primary --mode 2560x1440 --pos 0x240 --rotate normal --output DVI-D-1 --off
echo "Monitor layout set to 2560x60 (horizontal) ^ 1920x80 (vert)"
