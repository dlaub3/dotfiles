#!/bin/bash

source $HOME/.config/i3/scripts/floating_resize.sh


WINDOW=$(i3-msg -t get_tree | jq -r '.. | objects | select(.window) | select(.window_properties?.instance | contains("claude.ai"))')
WINDOW_ID=$(jq '.window' <<<"$WINDOW")
IS_FOCUSED=$(jq '.focused' <<<"$WINDOW")

if [ -n "$WINDOW_ID" ]; then
    if  [[ "${IS_FOCUSED,,}" != "true" ]]; then
        i3-msg "[instance=\"claude\"] floating enable;"
        i3-msg "[instance=\"claude\"] move container to workspace current;"
        i3-msg "[instance=\"claude\"] resize set $WIDTH $HEIGHT"
        i3-msg "[instance=\"claude\"] move position center"
        i3-msg "[instance=\"claude\"] focus"
    else
        i3-msg "[instance=\"claude\"] move to workspace 🙈"
        i3-msg "[instance=\"claude\"] floating disable;"
        workspace 🙈 layout splitv
    fi
else
    # If the window doesn't exist, launch it
    brave -name claude --app="https://claude.ai/chat/d232c44b-b265-4246-846b-0bd80e4aaacd" &
    sleep 0.5  # Allow the window to initialize
    i3-msg "[instance=\"claude\"] focus"
    i3-msg "[instance=\"claude\"] floating enable;"
    i3-msg "[instance=\"claude\"] resize set $WIDTH $HEIGHT"
    i3-msg "[instance=\"claude\"] move position center"
fi
