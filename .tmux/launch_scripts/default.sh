# Set some configuration options
SESSION=$USER

# Create a new, detached session
tmux new-session -d -s $SESSION

# Create a second window
tmux new-window -t $SESSION:1 -n 'default'

# Select and configure the first window
tmux select-window -t $SESSION:1
tmux split-window -v 
tmux send-keys 'cd ~/Documents' C-m

# Attach to the session
tmux attach-session -t $SESSION
