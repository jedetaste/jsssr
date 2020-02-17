#!/bin/bash

version="1.5.6-81"

install_hin_client() {

  download="https://download.hin.ch/download/distribution/install/${version}/HINClient_macos_${version//./_}.dmg"

  echo "=> Download '${download}'"
  curl -s -o "/tmp/HINClient_macos_${version//./_}.dmg" "${download}"

  extract_dir=$(dmg-extractor "/tmp/HINClient_macos_${version//./_}.dmg")

  echo "=> Running installer at '${extract_dir}/Install HIN Client.app/Contents/Resources/install.sh'"
  bash "${extract_dir}/Install HIN Client.app/Contents/Resources/install.sh"

}

if [ -z "$(defaults read "/Applications/HIN Client.app/Contents/Info.plist" CFBundleVersion 2>/dev/null)" ]; then
  echo "=> HIN Client not installed"
  install_hin_client
elif [ ! "$(defaults read "/Applications/HIN Client.app/Contents/Info.plist" CFBundleVersion 2>/dev/null)" = "${version}" ]; then
  echo "=> HIN Client outdated"
  install_hin_client
else
  echo "=> HIN Client installed and up-to-date with v${version}"
  exit 0
fi
