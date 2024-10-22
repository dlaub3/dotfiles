# TODO: commit binaries to repo for initial install
#
# # Kubectl
#
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
#
# # Neovim
#
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.local-env.sh
echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >> ~/.local-env.fish
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.local-env.sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.local-env.fish

#
# # Kitty
#
mkdir ~/.local/bin
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Create symbolic links to add kitty and kitten to PATH (assuming ~/.local/bin is in
# your system-wide PATH)
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
# Place the kitty.desktop file somewhere it can be found by the OS
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
# If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
# Update the paths to the kitty and its icon in the kitty desktop file(s)
sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
# Make xdg-terminal-exec (and hence desktop environments that support it use kitty)
echo 'kitty.desktop' > ~/.config/xdg-terminals.list

# Misc Ubuntu
sudo apt install fd-find ripgrep jq httpie xclip fzf git tmux screen rust lua feh bat ack tldr fish
# sudo apt install jetbrains-mono

# FNM
curl -fsSL https://fnm.vercel.app/install | bash
fnm use v20.17.0
corepack enable
yarn

# kubectx
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

# skaffold
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 && \
sudo install skaffold /usr/local/bin
rm skaffold

## Local DNS
apt install dnsmasq
# Caddy
# Download caddy server binary

# i3
mkdir ~/Pictures/wallpapers
apt install i3 i3status i3lock rofi scrot gnome-screenshot imagemagick xbacklight vmware-user-suid-wrapper xrandr

apt instal rust-all rust-coreutils lua5.4

# other
# python3-pyneovim, mkecert






