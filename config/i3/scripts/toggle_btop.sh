#!/bin/bash

ACTIVE_MONITOR=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .output')
SCREEN=$(xrandr --listmonitors | grep $ACTIVE_MONITOR | awk '{ print $3 }' | awk -F "x" '{ print $1 " "  $2 }' | awk -F "[/, ]" '{ print $1 "x" $3}')
SCREEN_WIDTH=$(echo $SCREEN | cut -d'x' -f1)
SCREEN_HEIGHT=$(echo $SCREEN | cut -d'x' -f2)
WIDTH=$(echo "$SCREEN_WIDTH * 0.9" | bc | sed 's/.0$//g' )
HEIGHT=$(echo "$SCREEN_HEIGHT * 0.9" | bc | sed 's/.0$//g' )


WINDOW_ID=$(i3-msg -t get_tree | jq -r '.. | objects | select(.window) | select(.name=="btop").window')
IS_HIDDEN=$(i3-msg -t get_workspaces | jq '.[] | select(.name == "monitor")')
ACTIVE_WORKSPACE=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')

if [ -n "$WINDOW_ID" ]; then
    if [ -n "$IS_HIDDEN" ]; then
        i3-msg "[instance=\"monitor\"] move container to workspace current;"
        i3-msg "[instance=\"monitor\"] resize set $WIDTH $HEIGHT"
        i3-msg "[instance=\"monitor\"] move position center"
    else
        i3-msg "[instance=\"monitor\"] move to workspace monitor"
    fi
else
    # If the window doesn't exist, launch it
    urxvt -name monitor -e btop &
    sleep 0.1  # Allow the window to initialize
    i3-msg "[instance=\"monitor\"] floating enable;"
    i3-msg "[instance=\"monitor\"] resize set $WIDTH $HEIGHT"
    i3-msg "[instance=\"monitor\"] move position center"
fi
