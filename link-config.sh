#!/usr/bin/env bash
set -x

for dir in $HOME/.dotfiles/config/*; do
  if [[ $dir ]]; then
    dir_name=$(basename $dir)
    ln -nfs "${dir}" "${HOME}/.config/${dir_name}"
  fi
done
