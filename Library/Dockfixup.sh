#!/bin/bash
  
  if ! pgrep -q cfprefsd; then 
    exit 0
  fi
  
  restartDock="false"
  
  if [[ $(su -l "$(/usr/local/bin/currentuser)" -c "/usr/local/bin/dockutil --find 'Siri'") == *"was found"* ]]; then
    su -l "$(/usr/local/bin/currentuser)" -c "/usr/local/bin/dockutil --remove 'Siri' --no-restart"
    restartDock="true"
  fi
  
  if [[ $(su -l "$(/usr/local/bin/currentuser)" -c "/usr/local/bin/dockutil --find 'Karten'") == *"was found"* ]]; then
    su -l "$(/usr/local/bin/currentuser)" -c "/usr/local/bin/dockutil --remove 'Karten' --no-restart"
    restartDock="true"
  fi
  
  if [[ $(su -l "$(/usr/local/bin/currentuser)" -c "/usr/local/bin/dockutil --find 'Fotos'") == *"was found"* ]]; then
    su -l "$(/usr/local/bin/currentuser)" -c "/usr/local/bin/dockutil --remove 'Fotos' --no-restart"
    restartDock="true"
  fi
  
  if [[ $(su -l "$(/usr/local/bin/currentuser)" -c "/usr/local/bin/dockutil --find 'iBooks'") == *"was found"* ]]; then
    su -l "$(/usr/local/bin/currentuser)" -c "/usr/local/bin/dockutil --remove 'iBooks' --no-restart"
    restartDock="true"
  fi
  
  if [ "${restartDock}" == "true" ]; then
    su -l "$(/usr/local/bin/currentuser)" -c "osascript -e 'tell app \"Dock\" to quit'"
  fi
