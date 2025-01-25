#!/bin/bash

# Get the ID of the currently focused window
FOCUSED_WINDOW=$(xdotool getwindowfocus)

# Get the geometry of the focused window
FOCUSED_WINDOW_GEOMETRY=$(xdotool getwindowgeometry --shell $FOCUSED_WINDOW)
eval "$FOCUSED_WINDOW_GEOMETRY"

# Calculate alert position (e.g., top-right of the focused window)
ALERT_X=$((X + WIDTH)) # Offset for alert width
ALERT_Y=$((Y + HEIGHT))          # Offset from the top of the window

# Move the currently active alert (assumes alert is focused when created)
i3-msg [window_role="alert"] move position $ALERT_X $ALERT_Y
i3-msg [window_role="pop-up"] move position $ALERT_X $ALERT_Y
i3-msg [window_role="task_dialog"] move position $ALERT_X $ALERT_Y
