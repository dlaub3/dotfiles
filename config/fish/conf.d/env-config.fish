set -xg SHELL (which fish)
set -xg EDITOR (which nvim)

set -xg PATH $HOME/.local/bin /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin

# LOCAL STUFF
source ~/.local-env.fish

# nvim
set -xg PATH "/usr/local/nvim/bin" $PATH

# rust
set -xg PATH "$HOME/.cargo/bin" $PATH

## go
set -xg PATH /usr/local/go/bin $PATH
set -xg GOPATH $HOME/go
set -xg PATH $PATH (go env GOPATH)/bin

## deno
set -xg DENO_INSTALL $HOME/.deno
set -xg PATH $DENO_INSTALL/bin $PATH

switch (uname)
    case Linux
        set -xg PATH $GOPATH/bin $PATH
        set -xg PATH $HOME/.local/bin $PATH
        set -xg PATH $HOME/.gem/ruby/2.7.0/bin $PATH
        set -xg PATH /usr/bin/vendor_perl $PATH
        set -xg PATH $HOME/.amplify/bin $PATH
    case Darwin
    case FreeBSD NetBSD DragonFly
        echo Hi Beastie!
    case '*'
        echo Hi, stranger!
end

# fnm set this last
#set -xg PATH $HOME/.fnm $PATH
#fnm env --shell=fish | source
source $HOME/.config/fish/conf.d/fnm.fish

## node
set -xg PATH $PATH (yarn global bin)
set -xg NPM_CONFIG_PREFIX ~/.npm-global
