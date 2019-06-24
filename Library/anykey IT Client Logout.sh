#!/bin/bash

  userName=(
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

  for ((i = 0; i < "${#userName[@]}"; i++)); do
    if [ -d "/Users/${userName[$i]}" ]; then
      echo "Set password policy for user ${userName[$i]}"
      /usr/bin/pwpolicy -u "${userName[$i]}" -setpolicy "canModifyPasswordforSelf=0"
    fi
  done

  # Create directory geloeschteHomes in Library

  if [ ! -d "/Library/geloeschteHomes/" ]; then
    /bin/mkdir "/Library/geloeschteHomes"
  fi

  # Move home directory to Library

  timeStamp=$(date +%Y-%m-%d-%H-%M-%S)

  for ((i = 0; i < "${#userName[@]}"; i++)); do
    if [ -d "/Users/${userName[$i]}" ]; then
      echo "Move home directory '/Users/${userName[$i]}' to Library"
      /bin/mv "/Users/${userName[$i]}" "/Library/geloeschteHomes/${userName[$i]}-${timeStamp}"
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
