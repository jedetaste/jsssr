#!/bin/bash

  recipe=(
    "firefox"
    "adobereaderdc"
    "adobeflash"
    "bbedit"
    "cyberduck"
    "dropbox"
    "evernote"
    "ewolke"
    "firefox"
    "googlechrome"
    "googleearth"
    "lehreroffice"
    "omnidisksweeper"
    "skitch"
    "skype"
    "vlc"
  )

  for ((i = 0; i < "${#recipe[@]}"; i++)); do
    /usr/local/bin/aky "${recipe[$i]}"
  done