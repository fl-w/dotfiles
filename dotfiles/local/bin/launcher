#!/bin/bash

if [ $# -eq 0 ]
  then
    rofi -modi drun -show drun # -show-icons #  -sidebar-mode
    elif [ "$1" = "-f" ]; then
      rofi -show combi -hide-scrollbar -line-margin 15 \
        -columns 3 -bw 0 -eh 2 -show-icons -fullscreen
    else
      echo "syntax: launcher [-f]"
fi
