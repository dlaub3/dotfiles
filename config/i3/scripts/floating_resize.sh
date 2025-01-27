#!/bin/bash

ACTIVE_MONITOR=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .output')
SCREEN=$(xrandr --listmonitors | grep $ACTIVE_MONITOR | awk '{ print $3 }' | awk -F "x" '{ print $1 " "  $2 }' | awk -F "[/, ]" '{ print $1 "x" $3}')
SCREEN_WIDTH=$(echo $SCREEN | cut -d'x' -f1)
SCREEN_HEIGHT=$(echo $SCREEN | cut -d'x' -f2)
WIDTH=$(echo "$SCREEN_WIDTH * 0.9" | bc | sed 's/.0$//g' )
HEIGHT=$(echo "$SCREEN_HEIGHT * 0.9" | bc | sed 's/.0$//g' )

i3-msg resize set "${WIDTH}px" "${HEIGHT}px"
i3-msg move position center
