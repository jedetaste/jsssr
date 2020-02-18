#!/bin/bash

echo "=> Download uninstaller 'https://fpdownload.macromedia.com/get/flashplayer/current/support/uninstall_flash_player_osx.dmg'"
curl -s -o "/tmp/uninstall_flash_player_osx.dmg" "https://fpdownload.macromedia.com/get/flashplayer/current/support/uninstall_flash_player_osx.dmg"

extract_dir=$(dmg-extractor "/tmp/uninstall_flash_player_osx.dmg")

echo "=> Running uninstaller at '${extract_dir}/Adobe Flash Player Uninstaller.app/Contents/MacOS/Adobe Flash Player Install Manager'"
"${extract_dir}/Adobe Flash Player Uninstaller.app/Contents/MacOS/Adobe Flash Player Install Manager" -uninstall

rm -rf "/tmp/uninstall_flash_player_osx.dmg"
