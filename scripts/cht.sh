#!/usr/bin/env bash

LANGUAGES="golang typescript lua bash vim javascript perl python php bash rust elixir ruby fish"
CORE_UTILS="find grep awk sed ps lsof"
MIX=$(tr " " "\n" <<< "${LANGUAGES} ${CORE_UTILS}" )
SELECTED=$(fzf <<< $MIX)

read -p "Query:" QUERY

if  rg -qs $SELECTED <<< $LANGUAGES; then
 #tmux split-window -p 22 -h bash -c "http cht.sh/$SELECTED/$(tr " " "+" <<< $QUERY) | bat --pager="less -R" --language="$SELECTED""
  http cht.sh/$SELECTED/$(tr " " "+" <<< $QUERY)
else
  http cht.sh/$SELECTED/$(tr " " "+" <<< $QUERY) 
fi
