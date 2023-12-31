#!/bin/bash

list_devices() {
    pacmd list-sinks | grep -e "index:" -e "device.description"  | \
    awk -F"= |: " ' /index:/{idx=$2}
                    /device.description/{description=$2}
                    { if (NR % 2 == 0) {print idx " " description} }' | \
    sed 's/"//g'
}

set_default_device() {
    local device_desc="$1"
    local device_index=$(echo "$device_desc" | awk '{print $1}')

    pacmd set-default-sink "$device_index"
    pacmd list-sink-inputs | awk '/index:/{print $2}' | while read -r stream
    do
        pacmd move-sink-input "$stream" "$device_index"
    done
    echo "Default audio device set to $device_desc."
}

# Main script logic
DEVICE_DESC=$(list_devices | rofi -dmenu -i -p "Select Audio Device:")

if [ -n "$DEVICE_DESC" ]; then
    set_default_device "$DEVICE_DESC"
else
    echo "No device selected or rofi closed."
fi
