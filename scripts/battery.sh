#!/usr/bin/env bash

upower -i $(upower -e | grep 'BAT') | grep --color -E "state|time to full|percentage"
