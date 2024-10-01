#!/usr/bin/env bash
set -x

for file in $HOME/.dotfiles/home/*; do
  if [[ $file ]]; then
    file_name=$(basename $file)
    ln -nfs "${file}" "${HOME}/.${file_name}"
  fi
done
