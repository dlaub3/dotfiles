#!/bin/bash

list_cards() {
  pacmd list-cards | grep -e "index:" -e "active profile" | \
    awk -F ": " '
         /index:/{idx=$2}
         /active profile:/{name=$2}
         {
           if (length(name) && name != seen) {print idx " " name}
           seen=name
          }
         ' | \
    sed 's/["<>]//g'
}

set_default_card() {
    local card_name="$1"
    local card_index=$(echo "$card_name" | awk '{print $1}')

    pacmd set-card-profile "$card_name"
    pacmd list-sink-inputs | awk '/index:/{print $2}' | while read -r stream
    do
        pacmd move-sink-input "$stream" "$card_index"
    done
    echo "Default audio card set to \"$card_name\"."
}

# Main script logic
card_name=$(list_cards | rofi -dmenu -i -p "Select Audio card:")

if [ -n "$card_name" ]; then
    set_default_card "$card_name"
else
    echo "No card selected or rofi closed."
fi
