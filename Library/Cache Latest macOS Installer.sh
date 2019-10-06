#!/bin/bash

IFS='.' read -r major minor revision < <(sw_vers -productVersion)

if [ "${minor}" -gt 14 ]; then
  echo "Error: This Mac seems to run a beta of macOS" && exit 0
else
  /usr/local/bin/erase-install --move --os="${14}"
fi
