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
mkdir ~/.vimsessions
# ln -nfs ~/.dotfiles/gitconfig  ~/.gitconfig # This might overwrite important info for [user]
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
npm install -g instant-markdown-d
