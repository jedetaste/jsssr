#!/bin/bash -x

# Set the current keyboard layout on the login window

defaults write "/Library/Preferences/com.apple.HIToolbox" "AppleCurrentKeyboardLayoutInputSourceID" -string "com.apple.keylayout.SwissGerman"

# Set enabled keyboards on the current login window

defaults write "/Library/Preferences/com.apple.HIToolbox" "AppleEnabledInputSources" -array '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>19</integer><key>KeyboardLayout Name</key><string>Swiss German</string></dict>'

# Set the "selected" Input Source on the login window

defaults write "/Library/Preferences/com.apple.HIToolbox" "AppleSelectedInputSources" -array '<dict><key>InputSourceKind</key><string>Keyboard Layout</string><key>KeyboardLayout ID</key><integer>19</integer><key>KeyboardLayout Name</key><string>Swiss German</string></dict>'
