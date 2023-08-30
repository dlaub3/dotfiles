#!/bin/bash

sed -i 's/--dpi 196/--dpi 100/' $HOME/.config/i3/config
sed -i 's/196/100/' $HOME/.Xresources
