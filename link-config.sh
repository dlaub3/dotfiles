#!/usr/bin/env bash

for dir in $HOME/.dotfiles/config/*; do
  if [[ $dir ]]; then
    dir_name=$(basename $dir)
    echo "ln -nfs ${dir}" "${HOME}/.config/${dir_name}"
    ln -nfs "${dir}" "${HOME}/.config/${dir_name}"
  fi
done
