#!/bin/bash
xrandr --output "eDP-1-1" --mode 1920x1080 --right-of "DP-0.2"
xrandr --output "DP-0.2" --mode 2560x1440 --left-of "eDP-1-1"
xrandr --output "DP-0.3" --mode 2560x1440 --left-of "DP-0.2"
