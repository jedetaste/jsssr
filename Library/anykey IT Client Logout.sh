#!/bin/bash

  username=(
    'gastschule'
    'gastkonto'
    'lernende'
    'lokal'
    'mittelstufe'
    'unterstufe'
    'schueler'
    'schuler'
    'sus'
    'schule'
    'stud'
    'student'
  )

  # Set password policy

  for ((i = 0; i < "${#username[@]}"; i++)); do
    if [ -d "/Users/${username[$i]}" ]; then
      echo "Set password policy for user ${username[$i]}"
      pwpolicy -u "${username[$i]}" -setpolicy "canModifyPasswordforSelf=0"
    fi
  done

  # Create directory geloeschteHomes in Library

  if [ ! -d "/Library/geloeschteHomes/" ]; then
    mkdir -p "/Library/geloeschteHomes"
  fi

  # Move home directory to Library

  timestamp=$(date +%Y-%m-%d-%H-%M-%S)

  for ((i = 0; i < "${#username[@]}"; i++)); do
    if [ -d "/Users/${username[$i]}" ]; then
      echo "Move home directory '/Users/${username[$i]}' to Library"
      mv "/Users/${username[$i]}" "/Library/geloeschteHomes/${username[$i]}-${timestamp}"
    fi
  done

  # Set permissions

  chown -R admin "/Library/geloeschteHomes/" && chmod -R 700 "/Library/geloeschteHomes/"

  # Cancel all print jobs

  cancel -a

  # Restart all disabled printers

  lpstat -p | grep "disabled" | awk '{print $2}' | xargs -n 1 -I{} sudo cupsenable {}

  # Kill CloudKeychainProxy

  killall CloudKeychainProxy
