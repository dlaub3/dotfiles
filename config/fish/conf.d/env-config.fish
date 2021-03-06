set -xg SHELL (which fish)
set -xg EDITOR (which nvim)

set -xg PATH $HOME/.local/bin /usr/local/bin /usr/local/sbin /usr/bin /usr/sbin /bin /sbin

## go
set -xg GOPATH $HOME/go
set -xg PATH $PATH (go env GOPATH)/bin 

## deno
set -xg DENO_INSTALL $HOME/.deno
set -xg PATH $DENO_INSTALL/bin $PATH

## node
set -xg PATH $PATH (yarn global bin)
set -xg NPM_CONFIG_PREFIX ~/.npm-global

switch (uname)
    case Linux
        alias dev 'cd /storage/dev'
        set -gx GOPATH /storage/dev/go
        set -xg GOROOT /usr/lib/go
        set -xg PATH $GOPATH/bin $PATH
        set -xg PATH $HOME/.local/bin $PATH
        set -xg PATH $HOME/.gem/ruby/2.7.0/bin $PATH
        set -xg PATH /usr/bin/vendor_perl $PATH
    case Darwin
    case FreeBSD NetBSD DragonFly
        echo Hi Beastie!
    case '*'
        echo Hi, stranger!
end

# fnm set this last
set -xg PATH $HOME/.fnm $PATH
fnm env --shell=fish | source

