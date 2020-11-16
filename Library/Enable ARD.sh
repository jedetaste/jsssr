#!/bin/bash

# Enable SSH and add admin to SSH group

systemsetup -setremotelogin on
dseditgroup -o edit -n /Local/Default -a admin -t user com.apple.access_ssh

# Re-Configure ARD and activate for User admin and gucken

kickstart="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"

if [ -n "$(id -u gucken)" ]; then
  echo "User id gucken exists"
  "${kickstart}" -activate -configure -allowAccessFor -specifiedUsers
  "${kickstart}" -configure -users admin,gucken -access -on -privs -all
  defaults write /Library/Preferences/com.apple.loginwindow HiddenUsersList -array-add gucken
else
  echo "User id gucken does not exist"
  "${kickstart}" -activate -configure -allowAccessFor -specifiedUsers
  "${kickstart}" -configure -users admin -access -on -privs -all
fi

# Deactivate Screen Sharing Request Login

defaults write "/Library/Preferences/com.apple.RemoteManagement" ScreenSharingReqPermEnabled -bool NO
