#!/usr/bin/env sh

# kill picom & wait until it has been shut down
killall -q picom
while pgrep -x picom >/dev/null; do sleep 1; done

picom -b --experimental-backends
