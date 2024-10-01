#!/bin/bash

EMAIL=$(cat $HOME/.dotfiles/email)
if [ -z "${EMAIL}" ]; then
  echo "var \$EMAIL is empty"
  exit 1
fi

FILE="$HOME/.dotfiles/gitconfig.local"
if ! [ -e "${FILE}" ]; then
  cp "$HOME/.dotfiles/gitconfig" "${FILE}"
fi


sed -i "s/Daniel Laubacher/Daniel/g" $FILE
sed -i "s/dlaubacher3@gmail.com/$EMAIL/g" $FILE

ln -nfs "${FILE}" "${HOME}/.gitconfig"
