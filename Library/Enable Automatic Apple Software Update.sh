#!/bin/bash
# shellcheck disable=SC2071

property_list="/Library/Preferences/com.apple.SoftwareUpdate.plist"

defaults write "${property_list}" AutomaticCheckEnabled -bool true
defaults write "${property_list}" AutomaticDownload -bool true
defaults write "${property_list}" ConfigDataInstall -bool true
defaults write "${property_list}" CriticalUpdateInstall -bool true
defaults write "${property_list}" AllowPreReleaseInstallation -bool true

if [[ "$(sw_vers -buildVersion)" > "17" ]]; then
  defaults write "${property_list}" AutomaticallyInstallMacOSUpdates -bool true
fi

property_list="/Library/Preferences/com.apple.commerce.plist"

defaults write "${property_list}" AutoUpdate -bool true

if [[ "$(sw_vers -buildVersion)" > "13" ]] && [[ "$(sw_vers -buildVersion)" < "17" ]]; then
  defaults write "${property_list}" AutoUpdateRestartRequired -bool true
fi
