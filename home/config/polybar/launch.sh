#!/usr/bin/env sh

## Add this to your wm startup file.
bar_type=single

if [ "$THEME" = "light" ]; then COLOR_THEME="theme/light";
else COLOR_THEME="theme/dark"; fi

launch_bar() {
    if [ $1 = "split" ]; then
        for bar in left center right; do
            polybar --reload $bar &
        done
    else
        polybar --reload single &
    fi
}

# Launch bar for all monitors
if command -v xrandr &> /dev/null; then
    for MONITOR in $(xrandr --query | grep -i connected | grep -v disconnected | cut -d ' ' -f1); do
        MONITOR="$MONITOR" launch_bar $bar_type
    done
else
    launch_bar $bar_type
fi
