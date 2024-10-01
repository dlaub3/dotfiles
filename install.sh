#!/bin/bash
./link-home.sh
./link-config.sh
ln -nfs ~/.dotfiles/tmux/* ~/.tmux
ln -nfs ~/.dotfiles/fonts ~/.fonts
mkdir ~/.vimsessions
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

file="~/.local-env.fish"
if ! [ -e "$file" ] ; then
    touch "$file"
fi

file="~/.local-env.sh"
if ! [ -e "$file" ] ; then
    touch "$file"
fi

#npm install -g instant-markdown-d

#curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > ~/.config/nvim/autoload/plug.vim
#curl -fsSL https://fnm.vercel.app/install | bash

#rm -rf /usr/local/go && tar -C ~/.local/asdf/ -xzf go1.20.1.linux-amd64.tar.gz
#eval (fnm env)
#corepack enable

# FiraCode fonts  https://github.com/tonsky/FiraCode
# FiraCode Nerd Fonts https://www.nerdfonts.com/font-downloads
# JetBrains Mono Font  https://www.jetbrains.com/lp/mono/
#
# docker
#
