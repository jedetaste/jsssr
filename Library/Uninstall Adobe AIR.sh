#!/bin/bash

version="32.0"
download="https://airdownload.adobe.com/air/mac/download/${version}/AdobeAIR.dmg"

echo "=> Download uninstaller '${download}'"
curl -s -o "/tmp/AdobeAIR.dmg" "${download}"

extract_dir=$(dmg-extractor "/tmp/AdobeAIR.dmg")

echo "=> Running uninstaller at '${extract_dir}/Adobe AIR Installer.app/Contents/MacOS/Adobe AIR Installer'"
"${extract_dir}/Adobe AIR Installer.app/Contents/MacOS/Adobe AIR Installer" -uninstall

rm -rf "/tmp/AdobeAIR.dmg"
