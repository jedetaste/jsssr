#/bin/bash

su -l "$(/usr/local/bin/currentuser)" -c "defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true && killall cfprefsd"

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
