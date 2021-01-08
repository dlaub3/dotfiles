export GOPATH=$HOME/go
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$(go env GOPATH)/bin # Add the bin folder to your path so you can run your programms 

export PATH="$PATH:$(yarn global bin)"
export PATH="$PATH:$HOME/.node_modules/bin"
export npm_config_prefix=~/.node_modules

bash ${HOME}/.conky/conky_rings/start.sh & guake & 
