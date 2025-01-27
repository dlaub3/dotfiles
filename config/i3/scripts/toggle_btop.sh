#!/bin/bash

source $HOME/.config/i3/scripts/floating_resize.sh

WINDOW_ID=$(i3-msg -t get_tree | jq -r '.. | objects | select(.window) | select(.name=="btop").window')
IS_HIDDEN=$(i3-msg -t get_workspaces | jq '.[] | select(.name == "monitor")')
ACTIVE_WORKSPACE=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')

if [ -n "$WINDOW_ID" ]; then
    if [ -n "$IS_HIDDEN" ]; then
        i3-msg "[instance=\"monitor\"] move container to workspace current;"
        i3-msg "[instance=\"monitor\"] resize set $WIDTH $HEIGHT"
        i3-msg "[instance=\"monitor\"] move position center"
        i3-msg "[instance=\"monitor\"] focus"
    else
        i3-msg "[instance=\"monitor\"] move to workspace monitor"
    fi
else
    # If the window doesn't exist, launch it
    urxvt -name monitor -e btop &
    sleep 0.1  # Allow the window to initialize
    i3-msg "[instance=\"monitor\"] focus"
    i3-msg "[instance=\"monitor\"] floating enable;"
    i3-msg "[instance=\"monitor\"] resize set $WIDTH $HEIGHT"
    i3-msg "[instance=\"monitor\"] move position center"
fi
