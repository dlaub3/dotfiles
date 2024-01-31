#!/bin/bash
primary_display="eDP-1-1"
xrandr --output $primary_display --mode 1920x1080 --primary --auto
# xrandr --output $primary_display --off
xrdb -merge ~/.Xresources

connected_displays=$(xrandr -q | grep " connected" | awk '{print $1}')
 for display in $connected_displays; do
     if [ "$display" != "$primary_display" ]; then
         xrandr --output $display --off
     fi
 done
