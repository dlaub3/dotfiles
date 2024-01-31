#!/bin/bash

list_ports() {
    pacmd list-cards | grep -e "index:" -e "analog-output-\w*:"  | \
    awk '/index:/{idx=$2}
         /analog-output-\w*/{name=$1}
         {
           if (length(name) && name != seen) {print idx " " name}
           seen=name
         }
        ' | \
    sed 's/[":]//g'
}

set_default_port() {
    local port_desc="$1"
    local port_index=$(echo "$port_desc" | awk '{print $1}')

    pacmd set-sink-port "$port_desc"
    #pacmd list-sink-inputs | awk '/index:/{print $2}' | while read -r stream
    #do
    #    pacmd move-sink-input "$stream" "$port_index"
    #done
    echo "Default audio port set to \"$port_desc\"."
}

# Main script logic
port_DESC=$(list_ports | rofi -dmenu -i -p "Select Audio port:")

if [ -n "$port_DESC" ]; then
    set_default_port "$port_DESC"
else
    echo "No port selected or rofi closed."
fi
