#!/bin/bash
xrandr --output "eDP1" --mode 1920x1080 --right-of "DP-1-0.2"
xrandr --output "DP-1-0.2" --mode 2560x1440 --left-of "eDP1"
xrandr --output "DP-1-0.3" --mode 2560x1440 --left-of "DP-1-0.2"
