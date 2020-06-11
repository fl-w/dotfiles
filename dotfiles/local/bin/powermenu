#!/bin/sh

if [ $# -eq 0 ]
then
            options=" Lock| Logout| Shutdown| Reboot| Hibernate"
            ROFI_CMD="$(rofi -sep "|" -dmenu -i -p 'Power' -width 9 -hide-scrollbar -line-padding 4 -padding 20 -columns 5 -lines 1 <<< "$options")"
else
            ROFI_CMD=$1
fi

case "$ROFI_CMD" in
*Lock)
    ~/.local/bin/lockscreen
    ;;
*Logout)
    i3-msg exit
    ;;
*Shutdown)
   shutdown now
    ;;
*Reboot)
    reboot
    ;;
*Hibernate)
    systemctl hibernate
    ;;
esac
