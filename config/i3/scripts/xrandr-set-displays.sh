#!/usr/bin/bash

if xrandr --query | grep ' connected ' | grep -q 'HDMI-1-0'; then
  xrandr --output "eDP1" --mode 1920x1080 --left-of "HDMI-1-0"
  xrandr --output "HDMI-1-0" --mode 3440x1440 --right-of "eDP1"
elif xrandr --query | grep ' connected ' | grep -q 'DP-1-3'; then
  xrandr --output "eDP1" --mode 1920x1080 --right-of "DP-1-2"
  xrandr --output "DP-1-0.2" --mode 2560x1440 --left-of "eDP1"
  xrandr --output "DP-1-0.3" --mode 2560x1440 --left-of "DP-1-0.2"
else
  xrandr --output "eDP1" --mode 1920x1080 --auto
fi

