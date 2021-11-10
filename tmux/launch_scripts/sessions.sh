#!/usr/bin/env bash
# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/bin/tmux-sessionizer
SESSION=$(fd . /storage/dev -d1 | fzf)
SESSION_NAME=$(basename "${SESSION}" | tr . _)

if ! tmux has-session -t "${SESSION_NAME}" 2>/dev/null; then
  tmux new-session -s "${SESSION_NAME}" -c "${SESSION}" -d
fi 

tmux switch-client -t "${SESSION_NAME}"
