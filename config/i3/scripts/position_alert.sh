#!/bin/bash

ACTIVE_MONITOR=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .output')
SCREEN=$(xrandr --listmonitors | grep $ACTIVE_MONITOR | awk '{ print $3 }' | awk -F "x" '{ print $1 " "  $2 }' | awk -F "[/, ]" '{ print $1 "x" $3}')

SCREEN_WIDTH=$(echo $SCREEN | cut -d'x' -f1)
SCREEN_HEIGHT=$(echo $SCREEN | cut -d'x' -f2)

ALERT_Y=50 #$(bc $SCREEN_HEIGHT - 100)
ALERT_X=50 #$(bc $SCREEN_WIDTH - 200)

i3-msg [window_role="alert"] move position $ALERT_X $ALERT_Y;
i3-msg [window_role="popup"] move position $ALERT_X $ALERT_Y;
i3-msg [window_role="task_dialog"] move position $ALERT_X $ALERT_Y;
i3-msg [window_type="notification"] move position $ALERT_X $ALERT_Y;
i3-msg [window_type="tooltip"] move position $ALERT_X $ALERT_Y;
i3-msg [window_type="MENU|SPLASH|DIALOG|POPUP|NOTIFICATION"] move position $ALERT_X $ALERT_Y;

i3-msg [window_role="alert"] move container to workspace current;
i3-msg [window_role="popup"] move container to workspace current;
i3-msg [window_role="task_dialog"] move container to workspace current;
i3-msg [window_type="notification"] move container to workspace current;
i3-msg [window_type="tooltip"] move container to workspace current;
i3-msg [window_type="MENU|SPLASH|DIALOG|POPUP|NOTIFICATION"] move container to workspace current;
