#!/bin/bash

REPO=$1
MATCH=$2
APP_NAME=$(basename $REPO)
FILE_NAME=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" | jq ".assets[] | select(.name|match(\"${MATCH}\")) | .name" | tr -d '"')
DOWNLOAD_URL=$(curl -s "https://api.github.com/repos/${REPO}/releases/latest" | jq ".assets[] | select(.name|match(\"${MATCH}\")) | .browser_download_url" |  tr -d '"')

mkdir ~/Downloads/asdf
cd ~/Downloads/asdf

curl -L $DOWNLOAD_URL -o $FILE_NAME

if [[ $FILE_NAME =~ txz$ ]];
then
    OUT_DIR=$(echo $FILE_NAME | sed "s/.txz$//")
    tar Jxf $FILE_NAME -C $APP_NAME
    if  ls $APP_NAME | grep bin;
    then 
      mkdir -p ~/.local/asdf/${APP_NAME}
      rm -rf   ~/.local/asdf/${APP_NAME}/*
      mv -f   $APP_NAME/* ~/.local/asdf/${APP_NAME}
      echo "~/.local/asdf/${APP_NAME}"
      ls        ~/.local/asdf/${APP_NAME}
    else
      mkdir -p ~/.local/asdf/${APP_NAME}
      rm -rf   ~/.local/asdf/${APP_NAME}/*
      mv -f  $APP_NAME/$OUT_DIR/* ~/.local/asdf/${APP_NAME}
      echo "~/.local/asdf/${APP_NAME}"
      ls        ~/.local/asdf/${APP_NAME}
    fi
elif [[ $FILE_NAME =~ tar.gz$ ]];
then
  echo $FILE_NAME
    tar xzf $FILE_NAME -C $APP_NAME
    if ls $APP_NAME | grep bin;
    then 
      mkdir -p ~/.local/asdf/${APP_NAME}
      rm -rf   ~/.local/asdf/${APP_NAME}/*
      mv -f   $APP_NAME/* ~/.local/asdf/${APP_NAME}
      echo "~/.local/asdf/${APP_NAME}"
      ls        ~/.local/asdf/${APP_NAME}
    else
      mkdir -p ~/.local/asdf/${APP_NAME}
      rm -rf   ~/.local/asdf/${APP_NAME}/*
      mv -f  $APP_NAME/$OUT_DIR/* ~/.local/asdf/${APP_NAME}
      echo "~/.local/asdf/${APP_NAME}"
      ls        ~/.local/asdf/${APP_NAME}
    fi
elif [[ $FILE_NAME =~ .zip$ ]];
then
  echo $FILE_NAME
    gzip xzf $FILE_NAME -C $APP_NAME
    if ls $APP_NAME | grep bin;
    then 
      mkdir -p ~/.local/asdf/${APP_NAME}
      rm -rf   ~/.local/asdf/${APP_NAME}/*
      mv -f   $APP_NAME/* ~/.local/asdf/${APP_NAME}
      echo "~/.local/asdf/${APP_NAME}"
      ls        ~/.local/asdf/${APP_NAME}
    else
      mkdir -p ~/.local/asdf/${APP_NAME}
      rm -rf   ~/.local/asdf/${APP_NAME}/*
      mv -f  $APP_NAME/$OUT_DIR/* ~/.local/asdf/${APP_NAME}
      echo "~/.local/asdf/${APP_NAME}"
      ls        ~/.local/asdf/${APP_NAME}
    fi
fi

# ~/.local/asdf/neovim/bin
# ~/.local/asdf/kitty/bin
# ~/.local/asdf/tmux/bin
