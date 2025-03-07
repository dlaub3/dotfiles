#!/bin/bash

usage() {
  echo "Usage: $0 -d <domain> <file name>"
  exit 1
}

while getopts "d:" opt; do
  case ${opt} in
    d) DOMAIN="$OPTARG";;
    :) echo "Option -$OPTARG requires an argument." >&2; exit 1 ;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
    *) usage ;;
  esac
done

shift $((OPTIND-1))
if [ $# -eq 0 ]; then
  usage
fi

FILE_NAME=$1

if [ -z "$DOMAIN" ] || [ -z "$FILE_NAME" ]; then
  usage
fi
echo | openssl s_client -connect ${DOMAIN}:443 -servername ${DOMAIN} 2>/dev/null | awk '/-----BEGIN CERTIFICATE-----/,/-----END CERTIFICATE-----/' > "${FILE_NAME}"
