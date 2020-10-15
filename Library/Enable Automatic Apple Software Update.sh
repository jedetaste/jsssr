#!/bin/bash
# shellcheck disable=SC2034

set -x

OLDIFS="${IFS}"

IFS='.' read -r osvers_major osvers_minor osvers_dot_version <<<"$(/usr/bin/sw_vers -productVersion)"

IFS="${OLDIFS}"

property_list="/Library/Preferences/com.apple.SoftwareUpdate.plist"

defaults write "${property_list}" AutomaticCheckEnabled -bool true
defaults write "${property_list}" AutomaticDownload -bool true
defaults write "${property_list}" ConfigDataInstall -bool true
defaults write "${property_list}" CriticalUpdateInstall -bool true
defaults write "${property_list}" AllowPreReleaseInstallation -bool true

if [[ (${osvers_major} -eq 10 && ${osvers_minor} -ge 14) || (${osvers_major} -eq 11) ]]; then
  defaults write "${property_list}" AutomaticallyInstallMacOSUpdates -bool true
fi

property_list="/Library/Preferences/com.apple.commerce.plist"

defaults write "${property_list}" AutoUpdate -bool true

if [[ (${osvers_major} -eq 10 && (${osvers_minor} -ge 10 && ${osvers_minor} -lt 14)) ]]; then
  defaults write "${property_list}" AutoUpdateRestartRequired -bool true
fi
