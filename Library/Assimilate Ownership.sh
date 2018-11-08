#!/bin/bash
  
  applicationPath=(
    '/Applications/Scratch 2.app'
    '/Applications/Lernprogramme/TastaBasta Training/FlyingSnails.app'
    '/Applications/Lernprogramme/TastaBasta Training/TastaBasta Training.app'
  )
  
  for ((i = 0; i < "${#applicationPath[@]}"; i++)); do
    if [ -s "${domainPlist[$i]}" ]; then
      /usr/local/bin/assimilateownership --path "${domainPlist[$i]}"
    fi
  done