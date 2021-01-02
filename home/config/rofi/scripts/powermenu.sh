#!/bin/sh

theme=themes/powermenu
if [ $# -ne 0 -a "$1" = "-with-hint" ]
then
   options=" Lock| Logout| Shutdown| Reboot| Hibernate"
   theme="$theme-text"
else
   options="||||"
fi

case "$(rofi -sep '|' -dmenu -i -p 'Power' -theme $theme <<< "$options")" in
*Lock|)
    ~/.local/bin/lockscreen
    ;;
*Logout|)
    i3-msg exit
    ;;
*Shutdown|)
   shutdown now
    ;;
*Reboot|)
    reboot
    ;;
*Hibernate|)
    systemctl hibernate
    ;;
esac
