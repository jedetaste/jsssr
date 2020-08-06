#!/bin/bash

IFS='.' read -r major minor revision < <(sw_vers -productVersion)

if [ "${minor}" -gt 15 ]; then
  echo "=> Computer is running macOS ${major}.${minor}.${revision}"
  echo "Error: This Mac seems to run a beta of macOS" && exit 0
elif [ "${minor}" -lt 13 ]; then
  echo "=> Computer is running macOS ${major}.${minor}.${revision}"
  /usr/local/bin/erase-install --catalogurl=https://swscan.apple.com/content/catalogs/others/index-10.12-10.11-10.10-10.9-mountainlion-lion-snowleopard-leopard.merged-1.sucatalog --update --os=10.15
else
  echo "=> Computer is running macOS ${major}.${minor}.${revision}"
  /usr/local/bin/erase-install --update --os=10.15
fi
