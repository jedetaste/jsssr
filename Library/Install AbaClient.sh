#!/bin/bash

version="2.0.439"

install_abaclient() {

  download="https://storage.googleapis.com/images.abasky.net/119676df089a90ab3c3004398806433938052586dcd9a6bcacfb0e3e4024f339/${version}/abaclient-${version}.dmg"

  echo "=> Download '${download}'"
  curl -s -o "/tmp/abaclient-${version}.dmg" "${download}"

  extract_dir=$(dmg-extractor "/tmp/abaclient-${version}.dmg")

  echo "=> Running installer at '${extract_dir}/AbaClient.pkg'"
  installer -pkg "${extract_dir}/AbaClient.pkg" -target /

  echo "=> Running installer at '${extract_dir}/AbaClientManager.pkg'"
  installer -pkg "${extract_dir}/AbaClientManager.pkg" -target /

}

if [ -z "$(defaults read "/Applications/AbaClient.app/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null)" ]; then
  echo "=> AbaClient.app not installed"
  install_abaclient
elif [ ! "$(defaults read "/Applications/AbaClient.app/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null)" = "${version}" ]; then
  echo "=> AbaClient.app outdated"
  install_abaclient
else
  echo "=> AbaClient.app installed and up-to-date with v${version}"
  exit 0
fi
