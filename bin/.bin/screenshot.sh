#!/usr/bin/env bash

scrot "$@" ~/Pictures/Screenshots/Screenshot_%Y%m%d_%H%M%S.png -e 'notify-send "Screenshot saved as $n"'
