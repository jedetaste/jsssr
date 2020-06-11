#!/bin/bash

major_os_version=$(sw_vers -productVersion | awk -F. '{print $2}')

property_list="/Library/Preferences/com.apple.SoftwareUpdate.plist"

defaults write "${property_list}" AutomaticCheckEnabled -bool false
defaults write "${property_list}" AutomaticDownload -bool false
defaults write "${property_list}" ConfigDataInstall -bool false
defaults write "${property_list}" CriticalUpdateInstall -bool false
defaults write "${property_list}" AllowPreReleaseInstallation -bool false

if [[ "${major_os_version}" -ge 14 ]]; then
  defaults write "${property_list}" AutomaticallyInstallMacOSUpdates -bool false
  defaults write "${property_list}" AutoUpdate -bool false
fi

property_list="/Library/Preferences/com.apple.commerce.plist"

if [[ "${major_os_version}" -ge 10 ]] && [[ "${major_os_version}" -lt 14 ]]; then
  defaults write "${property_list}" AutoUpdateRestartRequired -bool false
fi
