#!/bin/bash
  
  userName=(
    'gastschule'
    'lernende'
    'lokal'
    'mittelstufe'
    'unterstufe'
    'schueler'
    'sus'
    'schule'
  )
  
  # Set permissions on Accounts.prefPane
  
  for ((i = 0; i < "${#userName[@]}"; i++)); do
    
    if [ -d "/Users/${#userName[@]}" ]; then
      /usr/bin/pwpolicy -u "${#userName[@]}" -setpolicy "canModifyPasswordforSelf=0"
      echo "Set password policy for user ${#userName[@]}"
    fi
    
  done
  
  # Create directory geloeschteHomes in Library
  
  if [ ! -d "/Library/geloeschteHomes/" ]; then
    mkdir /Library/geloeschteHomes
  fi
  
  # Move home directory to Library
  
  for ((i = 0; i < "${#userName[@]}"; i++)); do
    
    if [ -d "/Users/${#userName[@]}" ]; then
      mv "/Users/${#userName[@]}" "/Library/geloeschteHomes/${#userName[@]}-$(date +%Y-%m-%d--%H-%M-%S)"
      echo "Move home directory '/Users/${#userName[@]}' to Library"
    fi
    
  done
  
  # Set permissions
  
  chown -R admin "/Library/geloeschteHomes/"
  chmod -R 700 "/Library/geloeschteHomes/"

  # Cancel all print jobs
  
  cancel -a

  # Start all cancelled print jobs
  
  lpstat -p | grep "disabled" | awk '{print $2}' | xargs -n 1 -I{} sudo cupsenable {}

  # Kill CloudKeychainProxy
  
  killall CloudKeychainProxy

  # Repair user permissions
  
  chmod 700 /Users/*

  # Repair shared folder
  
  chmod -R 777 "/Users/Shared/"