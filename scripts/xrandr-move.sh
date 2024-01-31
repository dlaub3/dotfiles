#!/bin/bash
list_monitors() {
    xrandr --listactivemonitors | awk '{print $4}'
}

target_monitor=$(list_monitors | rofi -dmenu -i -p "Select Target Monitor:")
# List of your workspace names
workspaces=({1..20})

# Move each workspace to the target monitor
for ws in ${workspaces[@]}; do
    i3-msg "workspace $ws; move workspace to output $target_monitor"
done
