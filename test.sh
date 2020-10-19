#!/bin/sh
while true ;do
    [ -x "$(which ${DIALOG%% *})" ] || DIALOG=dialog
    DIALOG=$($DIALOG --menu "Which tool for next run?" 20 60 12 2>&1 \
            whiptail       "dialog boxes from shell scripts" >/dev/tty \
            dialog         "dialog boxes from shell with ncurses" \
            gdialog        "dialog boxes from shell with Gtk" \
            kdialog        "dialog boxes from shell with Kde" ) || exit
    clear;echo "Choosed: $DIALOG."
    for i in `seq 1 100`;do
        date +"`printf "XXX\n%d\n%%a %%b %%T progress: %d\nXXX\n" $i $i`"
        sleep .0125
      done | $DIALOG --gauge "Filling the tank" 20 60 0
    $DIALOG --infobox "This is a simple info box\n\nNo action required" 20 60
    sleep 3
    if $DIALOG --yesno  "Do you like this demo?" 20 60 ;then
        AnsYesNo=Yes; else AnsYesNo=No; fi
    AnsInput=$($DIALOG --inputbox "A text:" 20 60 "Text here..." 2>&1 >/dev/tty)
    AnsPass=$($DIALOG --passwordbox "A secret:" 20 60 "First..." 2>&1 >/dev/tty)
    $DIALOG --textbox /etc/motd 20 60
    AnsCkLst=$($DIALOG --checklist "Check some..." 20 60 12 \
        Correct "This demo is useful"        off \
        Fun        "This demo is nice"        off \
        Strong        "This demo is complex"        on 2>&1 >/dev/tty)
    AnsRadio=$($DIALOG --radiolist "I will:" 20 60 12 \
        " -1" "Downgrade this answer"        off \
        "  0" "Not do anything"                on \
        " +1" "Upgrade this anser"        off 2>&1 >/dev/tty)
    out="Your answers:\nLike: $AnsYesNo\nInput: $AnsInput\nSecret: $AnsPass"
    $DIALOG --msgbox "$out\nAttribs: $AnsCkLst\nNote: $AnsRadio" 20 60
  done

