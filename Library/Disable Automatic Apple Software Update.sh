#!/bin/bash
# shellcheck disable=SC2071

property_list="/Library/Preferences/com.apple.SoftwareUpdate.plist"

defaults write "${property_list}" AutomaticCheckEnabled -bool false
defaults write "${property_list}" AutomaticDownload -bool false
defaults write "${property_list}" ConfigDataInstall -bool false
defaults write "${property_list}" CriticalUpdateInstall -bool false
defaults write "${property_list}" AllowPreReleaseInstallation -bool false

if [[ "$(sw_vers -buildVersion)" > "17" ]]; then
  defaults write "${property_list}" AutomaticallyInstallMacOSUpdates -bool false
fi

property_list="/Library/Preferences/com.apple.commerce.plist"

defaults write "${property_list}" AutoUpdate -bool false

if [[ "$(sw_vers -buildVersion)" > "13" ]] && [[ "$(sw_vers -buildVersion)" < "17" ]]; then
  defaults write "${property_list}" AutoUpdateRestartRequired -bool false
fi
