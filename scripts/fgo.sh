#!/usr/bin/env bash
# use fzf to get the dirname used for chaning directories

fgo() {
  local FILE=$(fzf)
   
  if [[ "${?}" -eq 0 ]] 
  then
    echo $(dirname "${FILE}")
  else 
    echo "."
  fi

  return "${?}"
}

fgo
