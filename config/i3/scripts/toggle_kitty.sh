#!/bin/bash

source $HOME/.config/i3/scripts/floating_resize.sh

WINDOW=$(i3-msg -t get_tree | jq -r '.. | objects | select(.window) | select(.name =="toggle-kitty")')
WINDOW_ID=$(jq '.window' <<<"$WINDOW" | tail -n1)
IS_FOCUSED=$(jq '.focused' <<<"$WINDOW" | tail -n1)

if [ -n "$WINDOW_ID" ]; then
    if  [[ "${IS_FOCUSED,,}" != "true" ]]; then
        i3-msg "[title="toggle-kitty"] floating enable;"
        i3-msg "[title="toggle-kitty"] move container to workspace current;"
        i3-msg "[title="toggle-kitty"] resize set $WIDTH $HEIGHT"
        i3-msg "[title="toggle-kitty"] move position center"
        i3-msg "[title="toggle-kitty"] focus"
    else
        i3-msg "[title="toggle-kitty"] move to workspace 🙈"
        i3-msg "[title="toggle-kitty"] floating disable;"
        workspace 🙈 layout splitv
    fi
else
    # If the window doesn't exist, launch it
    kitty --title="toggle-kitty" &
    sleep 0.5  # Allow the window to initialize
    i3-msg "[title="toggle-kitty"] focus"
    i3-msg "[title="toggle-kitty"] floating enable;"
    i3-msg "[title="toggle-kitty"] resize set $WIDTH $HEIGHT"
    i3-msg "[title="toggle-kitty"] move position center"
fi
