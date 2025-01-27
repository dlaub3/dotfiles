#!/bin/bash

source $HOME/.config/i3/scripts/floating_resize.sh
echo $WIDTH:$HEIGHT

i3-msg resize set "${WIDTH}px" "${HEIGHT}px"
i3-msg move position center
