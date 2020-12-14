#!/bin/bash

sudo sv restart bluetoothd
for i in r8169 psmouse; do
    sudo modprobe -r $i
    sudo modprobe $i
done
