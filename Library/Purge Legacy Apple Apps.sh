#!/bin/bash

  applications_list=(
    "Pages.app"
    "Numbers.app"
    "Keynote.app"
    "GarageBand.app"
    "iMovie.app"
  )

  for applications in "${applications_list[@]}"; do
    if [ -s "/Applications/${applications}" ]; then
      if [ $(mdls -raw -name kMDItemAppStoreHasReceipt /Applications/${applications}) == "(null)" ]; then
        rm -rf "/Applications/${applications}"
      fi
    fi
  done

  /usr/local/bin/jamf "recon"