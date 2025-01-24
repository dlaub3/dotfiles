#!/bin/bash
xrdb -merge ~/.Xresources

primary_display=$(xrandr | rg ' connected ' | tr '\n' ' ' | awk '{ print $1 }')
mode=$(xrandr | rg ' connected ' | tr '\n' ' ' | awk '{ print $4 }' | sed "s/[0-9]+//g")

xrandr --output $primary_display --mode $mode --primary --auto

# connected_displays=$(xrandr -q | grep " connected" | awk '{print $1}')
#  for display in $connected_displays; do
#      if [ "$display" != "$primary_display" ]; then
#          xrandr --output $display --off
#      fi
#  done
