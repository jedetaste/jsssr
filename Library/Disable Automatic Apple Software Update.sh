#!/bin/bash
# shellcheck disable=SC2034

set -x

OLDIFS="${IFS}"

IFS='.' read -r osvers_major osvers_minor osvers_dot_version <<<"$(/usr/bin/sw_vers -productVersion)"

IFS="${OLDIFS}"

property_list="/Library/Preferences/com.apple.SoftwareUpdate.plist"

defaults write "${property_list}" AutomaticCheckEnabled -bool false
defaults write "${property_list}" AutomaticDownload -bool false
defaults write "${property_list}" ConfigDataInstall -bool false
defaults write "${property_list}" CriticalUpdateInstall -bool false
defaults write "${property_list}" AllowPreReleaseInstallation -bool false

if [[ (${osvers_major} -eq 10 && ${osvers_minor} -ge 14) || (${osvers_major} -eq 11) ]]; then
  defaults write "${property_list}" AutomaticallyInstallMacOSUpdates -bool false
fi

property_list="/Library/Preferences/com.apple.commerce.plist"

if [[ (${osvers_major} -eq 10 && (${osvers_minor} -ge 10 && ${osvers_minor} -lt 14)) ]]; then
  defaults write "${property_list}" AutoUpdateRestartRequired -bool false
fi
