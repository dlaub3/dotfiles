#!/bin/bash

usage() {
  echo "Usage: $0 -f <find> -r <replace>"
  exit 1
}

while getopts "f:r:" opt; do
  case ${opt} in
    f) FIND="$OPTARG";;
    r) REPLACE="$OPTARG";;
    :) echo "Option -$OPTARG requires an argument." >&2; exit 1 ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
    *) usage ;;
  esac
done
if [ -z "$FIND" ] || [ -z "$REPLACE" ]; then
  usage
fi

FILES=$(rg "$FIND" -l)

sed -i "s#${FIND}#${REPLACE}#g" $FILES
