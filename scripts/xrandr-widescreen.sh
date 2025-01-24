xrandr --output "eDP1" --mode 1920x1080 --left-of "HDMI-1-0"
xrandr --output "HDMI-1-0" --mode 3440x1440 --right-of "eDP1" # HDMI
xrandr --output "DP-1-0" --mode 3440x1440 --right-of "eDP1" # USB-C
xrandr --output "DP-1-1" --mode 3440x1440 --right-of "eDP1" # USB-C
