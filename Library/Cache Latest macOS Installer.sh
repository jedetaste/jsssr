#!/bin/bash

IFS='.' read -r major minor revision < <(sw_vers -productVersion)

if [ "${minor}" -gt 16 ]; then
  echo "Error: This Mac seems to run a beta of macOS" && exit 0
elif [ ! "${minor}" -eq 15 ]; then
  /usr/local/bin/erase-install --move --os=10.15
else
  echo "Computer is already on macOS 10.15"
fi
