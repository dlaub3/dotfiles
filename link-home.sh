#!/usr/bin/env bash

for file in $HOME/.dotfiles/home/*; do
  if [[ $file ]]; then
    file_name=$(basename $file)
    echo "ln -nfs ${file}" "${HOME}/.${file_name}"
    ln -nfs "${file}" "${HOME}/.${file_name}"
    # ln -nfs ~/.dotfiles/home/gitconfig  ~/.gitconfig # This might overwrite important info for [user]
  fi
done
