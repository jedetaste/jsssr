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
  '/Applications/Lernprogramme/New Headway'
  '/Applications/ClinDoeil.app'
  '/Applications/Millefeuilles.app'
  '/Applications/Signal.app'
  '/Applications/Lernprogramme/New Inspiration IC/'
  '/Applications/WhatsApp.app'
)

for ((i = 0; i < "${#applicationPath[@]}"; i++)); do
  if [ -s "${applicationPath[$i]}" ]; then
    echo "Assimilate ownership for '${applicationPath[$i]}'"
    /usr/local/bin/assimilateownership --path "${applicationPath[$i]}"
  fi
done
