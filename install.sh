#!/bin/bash
ln -nfs ~/.dotfiles/ackrc  ~/.ackrc
ln -nfs ~/.dotfiles/config/fish ~/.config/
ln -nfs ~/.dotfiles/config/nvim ~/.config/
ln -nfs ~/.dotfiles/config/kitty ~/.config/
ln -nfs ~/.dotfiles/config/bat ~/.config/
ln -nfs ~/.dotfiles/tmux/* ~/.tmux
ln -nfs ~/.dotfiles/tmux.conf  ~/.tmux.conf
ln -nfs ~/.dotfiles/gitignore_global  ~/.gitignore_global
ln -nfs ~/.dotfiles/ripgreprc  ~/.ripgreprc
ln -nfs ~/.dotfiles/profile  ~/.profile
ln -nfs ~/.dotfiles/bashrc  ~/.bashrc
ln -nfs ~/.dotfiles/bash_aliases  ~/.bash_aliases
ln -nfs ~/.dotfiles/Xresources ~/.Xresources
mkdir ~/.vimsessions
ln -nfs ~/.dotfiles/gitconfig  ~/.gitconfig # This might overwrite important info for [user]
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
touch ~/.local-env.fish
touch ~/.local-env.sh
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
