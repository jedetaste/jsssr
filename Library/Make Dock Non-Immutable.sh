#!/bin/bash

currentuser=$(/usr/local/bin/currentuser)

if [ -n "${currentuser}" ]; then
  if [ "$(su -l "${currentuser}" -c "defaults read com.apple.dock contents-immutable 2> /dev/null")" -eq 1 ]; then
    su -l "${currentuser}" -c "defaults write com.apple.dock contents-immutable -bool false"
    su -l "${currentuser}" -c "killall Dock"
  fi
fi
