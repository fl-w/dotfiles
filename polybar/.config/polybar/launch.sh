#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -qe polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar -r -c ~/.config/polybar/config.ini main &
