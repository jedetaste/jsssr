#!/bin/bash

application_path=(
  "/Applications/Slack.app"
  "/Applications/Spotify.app"
  "/Applications/WhatsApp.app"
  "/Applications/Scratch 2.app"
  "/Applications/Dropbox.app"
  "/Applications/Citrix Workspace.app"
  "/Applications/Signal.app"
  "/Applications/Minecraft.app"
  "/Applications/Notion.app"
  "/Applications/Lernprogramme/TastaBasta Training/"
  "/Applications/Lernprogramme/Blitzrechnen/"
  "/Applications/Lernprogramme/Clin dœil.app"
  "/Applications/Lernprogramme/Mille feuilles.app"
  "/Applications/Lernprogramme/New Headway"
  "/Applications/Lernprogramme/New Inspiration IC/"
  "/Applications/ClinDoeil.app"
  "/Applications/Millefeuilles.app"
  "/Applications/Autodesk Fusion 360.app"
)

for application in "${application_path[@]}"; do
  if [ -s "${application}" ]; then
    echo "Assimilate ownership for '${application}'"
    /usr/local/bin/assimilateownership --path "${application}"
  fi
done
