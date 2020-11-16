#!/bin/bash
# shellcheck disable=SC2154

version="$(curl -s -L "https://formulae.brew.sh/api/cask/soapui.json" | jq -r '.version')"

install_soapui() {

  echo "=> Download 'https://s3.amazonaws.com/downloads.eviware/soapuios/${version}/SoapUI-${version}.dmg'"

  curl -s -L -o "/tmp/SoapUI-${version}.dmg" "https://s3.amazonaws.com/downloads.eviware/soapuios/${version}/SoapUI-${version}.dmg"

  extract_dir=$(dmg-extractor "/tmp/SoapUI-${version}.dmg")

  echo "=> Run installer '${extract_dir}/SoapUI ${version} Installer.app/Contents/MacOS/JavaApplicationStub'"

  "${extract_dir}/SoapUI ${version} Installer.app/Contents/MacOS/JavaApplicationStub" \
    -q \
    -VcreateDesktopLinkAction"${Boolean}"=false \
    -Vsys.component.132"${Boolean}"=true \
    -Vsys.component.714"${Boolean}"=false \
    -Vsys.component.1263"${Boolean}"=false \
    -Vsys.component.2393"${Boolean}"=false \
    -VshowFileAction"${Boolean}"=false \
    -Vsys.installationDir=/Applications \
    -VexecutionLauncherAction"${Boolean}"=false

}

if [ -z "$(defaults read "/Applications/SoapUI-${version}.app/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null)" ]; then
  echo "=> SoapUI not installed"
  install_soapui
elif [ ! "$(defaults read "/Applications/SoapUI-${version}.app/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null)" = "${version}" ]; then
  echo "=> SoapUI outdated"
  install_soapui
else
  echo "=> SoapUI installed and up-to-date (v${version})"
  exit 0
fi
