#!/bin/sh
sleep 5
conky -q -c ${HOME}/.conky/conky_rings/cpu.rc &
conky -q -c ${HOME}/.conky/conky_rings/mem.rc & 
exit
