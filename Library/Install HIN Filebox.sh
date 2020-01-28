#!/bin/bash

version="2.5.3.0"

install_hin_filebox() {

  download="https://download.hin.ch/filebox2/HIN%20Filebox%20Installer.dmg"

  echo "=> Download '${download}'"
  curl -s -o "/tmp/HIN Filebox Installer" "${download}"

  extract_dir=$(dmg-extractor "/tmp/HIN Filebox Installer")

  echo "=> Running installer at '${extract_dir}/Install HIN Filebox.app/Contents/Resources/install.sh'"
  bash "${extract_dir}/Install HIN Filebox.app/Contents/Resources/install.sh"

}

if [ -z "$(defaults read "/Applications/HIN Filebox.app/Contents/Info.plist" CFBundleVersion 2>/dev/null)" ]; then
  echo "=> HIN Filebox not installed"
  install_hin_filebox
elif [ ! "$(defaults read "/Applications/HIN Filebox.app/Contents/Info.plist" CFBundleVersion 2>/dev/null)" = "${version}" ]; then
  echo "=> HIN Filebox outdated"
  install_hin_filebox
else
  echo "=> HIN Filebox installed and up-to-date with v${version}"
  exit 0
fi
