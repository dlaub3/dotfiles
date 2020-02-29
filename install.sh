#!/bin/bash
ln -nfs ~/.dotfiles/config/fish ~/.config/fish
ln -nfs ~/.dotfiles/config/nvim ~/.config/nvim
ln -nfs ~/.dotfiles/tmux  ~/.tmux
ln -nfs ~/.dotfiles/tmux.conf  ~/.tmux.conf
ln -nfs ~/.dotfiles/gitignore_global  ~/.gitignore_global
ln -nfs ~/.dotfiles/gitconfig  ~/.gitconfig # This might overwrite important info for [user]
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
