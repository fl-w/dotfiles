#!/bin/sh

tmp=/tmp/rofi-cycle-themes."$USER"

# create if not exists
touch $tmp

i=$(cat $tmp | wc -m)
rofi="~/.config/rofi/scripts/app-launcher.sh --window --combi --ssh --show combi"
case $(($i % 8)) in
  0) eval $rofi ;;
  1) eval $rofi --modes;;
  2) eval $rofi --modes -v modes;;
  3) eval $rofi --modes -v modes --right;;
  4) eval $rofi --sidebar;;
  5) eval $rofi --sidebar --modes;;
  6) eval $rofi --sidebar --right;;
  7) eval $rofi --sidebar --right --modes;;
esac

printf "+" >> $tmp
