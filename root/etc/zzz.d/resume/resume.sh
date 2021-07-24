#!/bin/sh
# resume.sh - post hibernate hook

# restart bluetooth
sv restart bluetoothd

# refresh drivers
for i in r8169 psmouse; do
    modprobe -r $i
    modprobe $i
done

# swap seems to keep growing after hibernation restore
# so clear swap
swapoff -a; swapon -a
