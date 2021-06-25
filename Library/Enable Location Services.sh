#!/bin/bash
# shellcheck disable=SC2071

echo "=> Enable location services"

if [[ "$(sw_vers -buildVersion)" > "16" ]]; then
  defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 1
  defaults write /Library/Preferences/com.apple.locationmenu "ShowSystemServices" -bool true
  launchctl kickstart -k system/com.apple.locationd
else
  sudo -u _locationd defaults -currentHost write com.apple.locationd LocationServicesEnabled -int 1
  defaults write /Library/Preferences/com.apple.locationmenu "ShowSystemServices" -bool true
fi
