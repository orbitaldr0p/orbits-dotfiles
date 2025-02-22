#!/bin/bash

check() {
    ENABLED=󱆶
    DISABLED=󰤽
    if easyeffects -b 3 | grep -q "0" ; then
        echo $DISABLED
    else
        echo $ENABLED
    fi
}

toggle() {
    if easyeffects -b 3 | grep -q "0" ; then
        notify-send "Disabling EQ" -t 2000 -r 91490
        easyeffects -b 1
    else
        notify-send "Enabling EQ" -t 2000 -r 91490
        easyeffects -b 2
    fi
}

case "$1" in
    c)
        check
    ;;
    t)
        toggle
    ;;
    *)
        invalid_input
    ;;
esac