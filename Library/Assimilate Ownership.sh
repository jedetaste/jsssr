#!/bin/bash

application_path=(
  '/Applications/Slack.app'
  '/Applications/Spotify.app'
  '/Applications/WhatsApp.app'
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
)

for application in "${application_path[@]}"; do
  if [ -s "${application}" ]; then
    echo "Assimilate ownership for '${application}'"
    /usr/local/bin/assimilateownership --path "${application}"
  fi
done
