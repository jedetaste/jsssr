#!/bin/bash

  version="2019.2.4.10"
  download="https://www.hidrive.strato.com/wget/TpAqjsrr"

  if [ -s "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle" ]; then
    version_installed=$(cat "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle/version.txt" | tr -d '[:space:]')
    if [ "${version_installed}" = "${version}" ]; then
      echo "==> School Craft Premium Content is up-to-date with v${version}" && exit 0
    fi
  fi

  tmpDir=$(/usr/local/bin/tmpDir)

  echo "==> Download '${download}'"
  curl -s -o "${tmpDir}/SchoolCraftPremiumContent.pkg" "${download}"

  if [ -s "${tmpDir}/SchoolCraftPremiumContent.pkg" ]; then

    echo "==> Prepare '${tmpDir}/SchoolCraftPremiumContent.pkg'"
    pkgutil --expand-full "${tmpDir}/SchoolCraftPremiumContent.pkg" "${tmpDir}/SchoolCraftPremiumContent-expanded.pkg"

    echo "==> Extract Payload 'SchoolCraft Premium Content.bundle'"
    if [ -s "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle" ]; then
      rm -rf "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle"
    fi

    mkdir -p "/Library/Application Support/WorksheetCrafter"

    mv "${tmpDir}/SchoolCraftPremiumContent-expanded.pkg/SchoolCraftPremiumContent.pkg/Payload/tmp/SchoolCraft Premium Content.bundle" "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle"
    chmod -R 755 "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle"
    
    for user in $(ls /Users | grep -v Shared | grep -v Guest | grep -v '.localized'); do
      if [ -s "/Users/${user}/Pictures/SchoolCraft Premium Content.bundle" ]; then
        rm -rf "/Users/${user}/Pictures/SchoolCraft Premium Content.bundle"
        echo "==> Symlink '/Users/${user}/Pictures/SchoolCraft Premium Content.bundle'"
        ln -s "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle" "/Users/${user}/Pictures"
      elif [ ! -s "/Users/${user}/Pictures/SchoolCraft Premium Content.bundle" ]; then
        echo "==> Symlink '/Users/${user}/Pictures/SchoolCraft Premium Content.bundle'"
        ln -s "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle" "/Users/${user}/Pictures"
      fi
    done

  fi

  rm -rf "${tmpDir}"

