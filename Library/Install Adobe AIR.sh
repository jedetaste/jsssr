#!/bin/bash

version="32.0"

download="https://airdownload.adobe.com/air/mac/download/${version}/AdobeAIR.dmg"

install_adobe_air() {

  echo "=> Download '${download}'"

  curl -s -L -o "/tmp/AdobeAIR.dmg" "${download}"

  extract_dir=$(dmg-extractor "/tmp/AdobeAIR.dmg")

  echo "=> Running installer at '${extract_dir}/Adobe AIR Installer.app/Contents/MacOS/Adobe AIR Installer'"
  "${extract_dir}/Adobe AIR Installer.app/Contents/MacOS/Adobe AIR Installer" -silent

}

if [ -z "$(defaults read "/Applications/Utilities/Adobe AIR Application Installer.app/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null)" ]; then
  echo "=> Adobe AIR not installed"
  install_adobe_air
elif [ ! "$(defaults read "/Applications/Utilities/Adobe AIR Application Installer.app/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null)" = "${version}" ]; then
  echo "=> Adobe AIR outdated"
  install_adobe_air
else
  echo "=> Adobe AIR installed and up-to-date (v${version})"
  exit 0
fi
