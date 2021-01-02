#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -qe polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar for all monitors
if command -v xrandr &> /dev/null; then
    for MONITOR in $(xrandr --query | grep -i connected | grep -v disconnected | cut -d ' ' -f1); 
    do
        MONITOR="$MONITOR" polybar --reload main &
    done
else
    polybar --reload main &
fi
