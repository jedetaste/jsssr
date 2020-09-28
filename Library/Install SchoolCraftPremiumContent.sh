#!/bin/bash

if [ -d "/Applications/WorksheetCrafter.app" ]; then

  version="2020.1.9.107"
  download="https://dl.cleverbridge.com/1010/rv7lo6-27027-63E0AFDA-236868974/SchoolCraftPremiumContent.pkg"

  if [ -s "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle" ]; then
    version_installed=$(cat <"/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle/version.txt" | tr -d '[:space:]')
    if [ "${version_installed}" = "${version}" ]; then
      echo "=> School Craft Premium Content is up-to-date with v${version}" && exit 0
    fi
  fi

  tmpDir=$(/usr/local/bin/tmpDir)

  echo "=> Download '${download}'"
  curl -s -o "${tmpDir}/SchoolCraftPremiumContent.pkg" "${download}"

  if [ -s "${tmpDir}/SchoolCraftPremiumContent.pkg" ]; then

    echo "=> Prepare '${tmpDir}/SchoolCraftPremiumContent.pkg'"
    pkgutil --expand-full "${tmpDir}/SchoolCraftPremiumContent.pkg" "${tmpDir}/SchoolCraftPremiumContent-expanded.pkg"

    echo "=> Extract Payload 'SchoolCraft Premium Content.bundle'"
    if [ -s "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle" ]; then
      rm -rf "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle"
    fi

    mkdir -p "/Library/Application Support/WorksheetCrafter"

    mv "${tmpDir}/SchoolCraftPremiumContent-expanded.pkg/SchoolCraftPremiumContent.pkg/Payload/tmp/SchoolCraft Premium Content.bundle" "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle"
    chmod -R 755 "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle"

    for user in /Users/*; do
      if [ ! "$(basename "${user}")" = "Shared" ]; then
        if [ -s "${user}/Pictures/SchoolCraft Premium Content.bundle" ]; then
          rm -rf "${user}/Pictures/SchoolCraft Premium Content.bundle"
          echo "=> Symlink '${user}/Pictures/SchoolCraft Premium Content.bundle'"
          ln -s "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle" "${user}/Pictures"
        elif [ ! -s "${user}/Pictures/SchoolCraft Premium Content.bundle" ]; then
          echo "=> Symlink '${user}/Pictures/SchoolCraft Premium Content.bundle'"
          ln -s "/Library/Application Support/WorksheetCrafter/SchoolCraft Premium Content.bundle" "${user}/Pictures"
        fi
      fi
    done

  fi

  rm -rf "${tmpDir}"

else
  echo "=> WorksheetCrafter.app is not installed"
fi
