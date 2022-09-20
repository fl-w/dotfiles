#!/bin/sh

theme=themes/powermenu
if [ $# -ne 0 ] && [ "$1" = "-with-hint" ]
then
   options=" Hibernate|ﰇ Reboot| Shutdown| Logout| Lock"
   theme="$theme-text"
else
   options="|ﰇ|||"
fi

case "$(rofi -sep '|' -dmenu -i -p 'Power' -theme $theme <<< "$options")" in
*Lock|)
    ~/.local/bin/lockscreen
    ;;
*Logout||)
    i3-msg exit
    ;;
*Shutdown|)
   loginctl poweroff
    ;;
*Reboot|ﰇ)
    loginctl reboot
    ;;
*Hibernate|)
    loginctl hibernate
    ;;
esac
