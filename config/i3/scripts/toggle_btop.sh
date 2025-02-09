#!/bin/bash

source $HOME/.config/i3/scripts/floating_resize.sh

WINDOW_ID=$(i3-msg -t get_tree | jq -r '.. | objects | select(.window) | select(.name=="btop").window')
IS_FOCUSED=$(i3-msg -t get_tree | jq -r '.. | objects | select(.window) | select(.name=="btop").focused')

if [ -n "$WINDOW_ID" ]; then
    if  [[ "${IS_FOCUSED,,}" != "true" ]]; then
        i3-msg "[instance=\"btop\"] floating enable;"
        i3-msg "[instance=\"btop\"] move container to workspace current;"
        i3-msg "[instance=\"btop\"] resize set $WIDTH $HEIGHT"
        i3-msg "[instance=\"btop\"] move position center"
        i3-msg "[instance=\"btop\"] focus"
    else
        i3-msg "[instance=\"btop\"] move to workspace 🙈"
        i3-msg "[instance=\"btop\"] floating disable;"
        workspace 🙈 layout splitv
    fi
else
    # If the window doesn't exist, launch it
    urxvt -name btop -e btop &
    sleep 0.1  # Allow the window to initialize
    i3-msg "[instance=\"btop\"] focus"
    i3-msg "[instance=\"btop\"] floating enable;"
    i3-msg "[instance=\"btop\"] resize set $WIDTH $HEIGHT"
    i3-msg "[instance=\"btop\"] move position center"
fi
