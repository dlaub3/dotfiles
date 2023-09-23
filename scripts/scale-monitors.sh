#!/bin/bash

sed -i 's/--dpi 196/--dpi 100/' $HOME/.xinitrc
sed -i 's/--dpi 196/--dpi 100/' $HOME/.config/i3/config
sed -i 's/monospace 24/monospace 12/' $HOME/.config/i3/config
sed -i 's/Mono 24/Mono 12/' $HOME/.config/rofi/config.rasi
sed -i 's/196/100/' $HOME/.Xresources
