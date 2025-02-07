#!/bin/bash

i3-msg scratchpad show
source $HOME/.config/i3/scripts/floating_resize.sh
WINDOW_ID=$(i3-msg -t get_tree | jq '.. | objects | select(.focused == true) | select(.floating == "user_on").window')

if [[ -z "${WINDOW_ID}" ]]; then
  i3-msg [id="$WINDOW_ID"] resize set "${WIDTH}px" "${HEIGHT}px"
  i3-msg [id="$WINDOW_ID"] move position center
fi
