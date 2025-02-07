#!/bin/bash

source $HOME/.config/i3/scripts/floating_resize.sh

WINDOW_ID=$(i3-msg -t get_tree | jq -r '.. | objects | select(.window) | select(.name=="ChatGPT").window')
IS_FOCUSED=$(i3-msg -t get_tree | jq -r '.. | objects | select(.window) | select(.name=="ChatGPT").focused')
ACTIVE_WORKSPACE=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')

if [ -n "$WINDOW_ID" ]; then
    if  [[ "${IS_FOCUSED,,}" != "true" ]]; then
        i3-msg "[instance=\"chatgpt\"] move container to workspace current;"
        i3-msg "[instance=\"chatgpt\"] resize set $WIDTH $HEIGHT"
        i3-msg "[instance=\"chatgpt\"] move position center"
        i3-msg "[instance=\"chatgpt\"] focus"
    else
        i3-msg "[instance=\"chatgpt\"] move to workspace chatgpt"
    fi
else
    # If the window doesn't exist, launch it
    brave -name chatgpt --app="https://chatgpt.com/?temporary-chat=true" &
    sleep 0.5  # Allow the window to initialize
    i3-msg "[instance=\"chatgpt\"] focus"
    i3-msg "[instance=\"chatgpt\"] floating enable;"
    i3-msg "[instance=\"chatgpt\"] resize set $WIDTH $HEIGHT"
    i3-msg "[instance=\"chatgpt\"] move position center"
fi
