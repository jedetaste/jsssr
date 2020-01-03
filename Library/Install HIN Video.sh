#!/bin/bash

version="2019-10-15_125635"

version_installed="3.6.18"

install_hin_video() {

  download="https://download.hin.ch/video/mac/HIN-Video-Installer_${version}.dmg"

  echo "=> Download '${download}'"
  curl -s -o "/tmp/HIN-Video-Installer_${version}.dmg" "${download}"

  extract_dir=$(dmg-extractor "/tmp/HIN-Video-Installer_${version}.dmg")

  echo "=> Running installer at '${extract_dir}/Install HIN Video.app/Contents/Resources/install.sh'"
  bash "${extract_dir}/Install HIN Video.app/Contents/Resources/install.sh"

  rm -rf "/tmp/HIN-Video-Installer_${version}.dmg"

}

if [ -z "$(defaults read "/Applications/HIN Video.app/Contents/Info.plist" CFBundleVersion 2>/dev/null)" ]; then
  echo "=> HIN Video not installed"
  install_hin_video
elif [ ! "$(defaults read "/Applications/HIN Video.app/Contents/Info.plist" CFBundleVersion 2>/dev/null)" = "${version_installed}" ]; then
  echo "=> HIN Video outdated"
  install_hin_video
else
  echo "=> HIN Video installed and up-to-date with v${version_installed}"
  exit 0
fi
