#!/usr/bin/env bash
# 
# https://revelry.co/resources/development/terminal-workflow-fzf/
#
# Search and destroy the PID of a process
# 
nuke() {
  local pid
  pid=$(ps -ef | grep -v ^root | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

nuke
