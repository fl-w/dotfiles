#!/usr/bin/env bash
monitor1=HDMI-1

reload_polybar() {
    notify-send "reloading polybar"
    # kill polybar & wait until it has been shut down
    killall -q polybar 
    while pgrep -x polybar >/dev/null; do sleep 1; done

    # MONITOR=$monitor1 polybar middle &
    # MONITOR=$monitor1 polybar right &
    MONITOR=$monitor1 polybar main &
}

reload_polybar