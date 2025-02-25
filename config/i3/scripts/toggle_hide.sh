#!/bin/bash

CLAUD_WINDOW_ID=$(i3-msg -t get_tree | jq -r '.. | objects | select(.window) | select(.window_properties?.instance | contains("claude.ai")).window')
CHAT_GPT_WINDOW_ID=$(i3-msg -t get_tree | jq -r '.. | objects | select(.window) | select(.window_properties?.instance =="chatgpt.com").window')
BTOP_WINDOW_ID=$(i3-msg -t get_tree | jq -r '.. | objects | select(.window) | select(.name=="btop").window')

for WINDOW_ID in $BTOP_WINDOW_ID $CHAT_GPT_WINDOW_ID $CLAUD_WINDOW_ID; do
  echo $WINDOW_ID
  if [ -n "$WINDOW_ID" ]; then
      i3-msg "[id=\"$WINDOW_ID\"] move to workspace 🙈"
      i3-msg "[id=\"$WINDOW_ID\"] floating disable;"
  fi
done
workspace 🙈 layout splitv
