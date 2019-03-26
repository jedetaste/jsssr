#!/bin/bash

  # Dependencies
  #
  # - Library ClinDoeil.pkg.zip

  # Install Adobe AIR

  /usr/local/bin/jsssr "Install Adobe AIR.sh"
  /usr/local/bin/jsssr "Adobe AIR EULA Acception.sh"

  # Uninstall legacy Mille feuilles.app

  /usr/local/bin/aky --remove clindoeil

  # Install Millefeuilles.app

  /usr/local/bin/aky --patch "https://github.com/jedetaste/aky-static/raw/master/clindoeil.json"

  # Link Library

  if [ -d "/Library/Application Support/Millefeuilles" ]; then

    for user in $(ls /Users | grep -v Shared | grep -v Guest | grep -v '.localized'); do
      if [ -d "/Users/${user}/Library/Application Support/Millefeuilles" ]; then
        rm -rf "/Users/${user}/Library/Application Support/Millefeuilles"
      fi
      ln -s "/Library/Application Support/Millefeuilles" "/Users/${user}/Library/Application Support/"
    done

    for usertemplate in "/System/Library/User Template"/*; do
      ln -s "/Library/Application Support/Millefeuilles" "${usertemplate}/Library/Application Support/"
    done

  fi