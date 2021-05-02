#!/bin/bash

# https://blog.adobe.com/en/publish/2019/05/30/the-future-of-adobe-air.html#gs.znji62

version="$(curl -s https://airsdk.harman.com/api/config-settings/download | jq -r '.latestVersion.supVersion')"

download="https://airsdk.harman.com/assets/downloads/AdobeAIR.dmg"

install_adobe_air() {

  echo "=> Download '${download}'"

  curl -s -L -o "/tmp/AdobeAIR.dmg" "${download}"

  extract_dir=$(dmg-extractor "/tmp/AdobeAIR.dmg")

  echo "=> Running installer at '${extract_dir}/Adobe AIR Installer.app/Contents/MacOS/Adobe AIR Installer'"
  "${extract_dir}/Adobe AIR Installer.app/Contents/MacOS/Adobe AIR Installer" -silent

}

if [ -z "$(defaults read "/Applications/Adobe AIR Installer.app/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null)" ]; then
  echo "=> Adobe AIR not installed"
  install_adobe_air
elif [ ! "$(defaults read "/Applications/Adobe AIR Installer.app/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null)" = "${version}" ]; then
  echo "=> Adobe AIR outdated"
  install_adobe_air
else
  echo "=> Adobe AIR installed and up-to-date (v${version})"
  exit 0
fi
