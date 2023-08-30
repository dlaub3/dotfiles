#!/bin/bash

sed -i 's/--dpi 100/--dpi 196/' $HOME/.config/i3/config
sed -i 's/100/196/' $HOME/.Xresources
