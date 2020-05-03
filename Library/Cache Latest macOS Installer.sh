#!/bin/bash

IFS='.' read -r major minor revision < <(sw_vers -productVersion)

if [ "${minor}" -gt 15 ]; then
  echo "=> Computer is running macOS ${major}.${minor}.${revision}"
  echo "Error: This Mac seems to run a beta of macOS" && exit 0
elif [ "${minor}" -lt 13 ]; then
  echo "=> Computer is running macOS ${major}.${minor}.${revision}"
  caffeinate -d -i -m -s &
  /usr/local/bin/erase-install --catalogurl=https://swscan.apple.com/content/catalogs/others/index-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog --overwrite --os=10.15
  killall caffeinate
elif [ ! "${minor}" -eq 15 ]; then
  echo "=> Computer is running macOS ${major}.${minor}.${revision}"
  caffeinate -d -i -m -s &
  /usr/local/bin/erase-install --overwrite --os=10.15
  killall caffeinate
else
  echo "=> Computer is already on macOS 10.15"
fi
