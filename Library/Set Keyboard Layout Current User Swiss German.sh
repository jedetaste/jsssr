#!/bin/bash -x

# Set the current keyboard layout on the current logged in user

su -l "$(/usr/local/bin/currentuser)" -c "defaults write com.apple.HIToolbox AppleCurrentKeyboardLayoutInputSourceID -string com.apple.keylayout.SwissGerman"

# Set enabled keyboards on the current logged in user

su -l "$(/usr/local/bin/currentuser)" -c "defaults write com.apple.HIToolbox AppleEnabledInputSources -array '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>19</integer><key>KeyboardLayout Name</key><string>Swiss German</string></dict>'"

# Set the "selected" Input Source on the current logged in user

su -l "$(/usr/local/bin/currentuser)" -c "defaults write com.apple.HIToolbox AppleSelectedInputSources -array '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>19</integer><key>KeyboardLayout Name</key><string>Swiss German</string></dict>'"

# Restart services

su -l "$(/usr/local/bin/currentuser)" -c "killall cfprefsd"
