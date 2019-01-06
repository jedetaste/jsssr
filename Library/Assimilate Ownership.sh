#!/bin/bash
  
  applicationPath=(
    '/Applications/Slack.app'
    '/Applications/Scratch 2.app'
    '/Applications/Dropbox.app'
    '/Applications/Minecraft.app'
    '/Applications/Lernprogramme/TastaBasta Training/'
    '/Applications/Lernprogramme/Blitzrechnen/'
    '/Applications/Lernprogramme/Clin dœil.app'
    '/Applications/Lernprogramme/Mille feuilles.app'
    '/Applications/Lernprogramme/New Inspiration IC/'
  )
  
  for ((i = 0; i < "${#applicationPath[@]}"; i++)); do
    if [ -s "${applicationPath[$i]}" ]; then
      /usr/local/bin/assimilateownership --path "${applicationPath[$i]}"
    fi
  done
