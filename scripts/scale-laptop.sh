#!/bin/bash

sed -i 's/--dpi 100/--dpi 196/' $HOME/.xinitrc
sed -i 's/--dpi 100/--dpi 196/' $HOME/.config/i3/config
sed -i 's/monospace 12/monospace 18/' $HOME/.config/i3/config
sed -i 's/Mono 12/Mono 24/' $HOME/.config/rofi/config.rasi
sed -i 's/100/196/' $HOME/.Xresources
